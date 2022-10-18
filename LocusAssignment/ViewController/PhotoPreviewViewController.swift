//
//  PhotoPreviewViewController.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/19/22.
//

import UIKit

class PhotoPreviewViewController: BaseViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var previewImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViews()
    }
    
    private func prepareViews() {
        photoImageView.image = previewImage
    }

    @IBAction func didTapOnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
