//
//  CommentTableViewCell.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet private weak var commentTitleLabel        : UILabel!
    @IBOutlet private weak var commentBox               : UIView!
    @IBOutlet private weak var commentSwitch            : UISwitch!
    @IBOutlet private weak var commentTextView          : UITextView!
    
    var updateCommentBlock : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(demoModel : DemoModel){
        commentTitleLabel.text = demoModel.title
        commentBox.isHidden = !demoModel.isCommentEnabled
        commentSwitch.isOn  = demoModel.isCommentEnabled
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func commentEnableDisable(_ sender: Any) {
        if let block = updateCommentBlock {
            block()
        }
    }
}
