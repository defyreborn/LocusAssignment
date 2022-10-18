//
//  PhotoTableViewCell.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var closeButtonOutlet    : UIButton!
    @IBOutlet private weak var photoImageView       : UIImageView!
    @IBOutlet private weak var photoTitleLabel      : UILabel!
    
    var removeImageBlock : (()->())?
    var updateImageBlock : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func set(demoModel : DemoModel){
        photoTitleLabel.text = demoModel.title
        closeButtonOutlet.isHidden = !demoModel.isPhotoSelected
        if demoModel.isPhotoSelected {
            photoImageView.image = Utill.loadImage(fileUrl: demoModel.photoLocation)
        } else {
            photoImageView.image = UIImage(named: "imagePlaceholder")
        }
    }
    
    @IBAction func didTapOnRemoveImage(_ sender: Any) {
        if let block = removeImageBlock {
            block()
        }
    }
    
    @IBAction func didTapOnChooseImage(_ sender: Any) {
        if let block = updateImageBlock {
            block()
        }
    }
}
