//
//  HomeViewController.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var tableView    : UITableView!
    var indexForImage = 0
    
    var demoDataArray : [DemoModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDemoData()
    }
    
    private func prepareViews() {
        
    }
    
    func getDemoData() {
        if let path = Bundle.main.path(forResource: "DemoData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON.init(data: data)
                self.demoDataArray = json.arrayValue.map({DemoModel.init($0)})
                self.tableView.reloadData()
            } catch {
                print("Error fetching demo data list")
            }
        }
    }
    
    @IBAction func didTapOnSubmit(_ sender: Any) {
        var filteredArr = demoDataArray.filter({$0.didUserResponded == true})
        print("================ Form Submitted Successfully =========================")
        print("User input id's : \(filteredArr.map({$0.id}))")
    }
    
    func optionsForImagePicker() {
        let alert = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.openImagePicker()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.openImagePicker(isCamera: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func openImagePicker(isCamera: Bool = false) {
        if isCamera {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                // unable to open camera
                return
            }
        }
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = !isCamera
        pickerController.sourceType = isCamera ? .camera : .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch demoDataArray[indexPath.row].mediaType {
        case .singleChoice :
            guard let cell = tableView.registerAndGet(cell: MCQTableViewCell.self) else {return UITableViewCell()}
            cell.set(demoModel: demoDataArray[indexPath.row])
            cell.updateCellBlock = { [weak self] () in
                guard let `self` = self else {return}
                self.demoDataArray[indexPath.row].didUserResponded = true
            }
            return cell
        case .comment :
            guard let cell = tableView.registerAndGet(cell: CommentTableViewCell.self) else {return UITableViewCell()}
            cell.set(demoModel: demoDataArray[indexPath.row])
            cell.updateCommentBlock = { [weak self] () in
                guard let `self` = self else {return}
                self.demoDataArray[indexPath.row].isCommentEnabled = !self.demoDataArray[indexPath.row].isCommentEnabled
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                self.demoDataArray[indexPath.row].didUserResponded = self.demoDataArray[indexPath.row].isCommentEnabled
            }
            return cell
        case .photo :
            guard let cell = tableView.registerAndGet(cell: PhotoTableViewCell.self) else {return UITableViewCell()}
            cell.set(demoModel: demoDataArray[indexPath.row])
            cell.removeImageBlock = {[weak self] () in
                guard let `self` = self else {return}
                self.demoDataArray[indexPath.row].isPhotoSelected = false
                self.demoDataArray[indexPath.row].photoLocation = URL(string: "")
                self.demoDataArray[indexPath.row].didUserResponded = false
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            cell.updateImageBlock = {[weak self] () in
                guard let `self` = self else {return}
                if self.demoDataArray[indexPath.row].isPhotoSelected {
                    if let previewImageViewController = UIStoryboard.main.get(PhotoPreviewViewController.self) {
                        previewImageViewController.previewImage = Utill.loadImage(fileUrl: self.demoDataArray[indexPath.row].photoLocation) ?? UIImage()
                        previewImageViewController.modalPresentationStyle = .overCurrentContext
                        previewImageViewController.modalTransitionStyle = .crossDissolve
                        self.present(previewImageViewController, animated: true)
                    }
                } else {
                    // show image picker
                    self.indexForImage = indexPath.row
                    self.optionsForImagePicker()
                }
            }
            return cell
        default : UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,let url = info[UIImagePickerController.InfoKey.imageURL] as? URL  {
            self.demoDataArray[indexForImage].isPhotoSelected = true
            self.demoDataArray[indexForImage].photoLocation = url
            self.demoDataArray[indexForImage].didUserResponded = true
            self.tableView.reloadData()
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
