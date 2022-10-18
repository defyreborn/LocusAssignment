//
//  CategoryTableViewCell.swift
//  DemoForTextField
//
//  Created by Raziya Mirza on 28/07/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var checkUncheckedLabel	            : UIImageView!
    @IBOutlet private weak var categoryNameLabel	            : UILabel!
    @IBOutlet private weak var categoryNameLeadingConstraint    : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var optionsDataMap : OptionsDataMap! {
        didSet {
            categoryNameLabel.text      = optionsDataMap.option
            checkUncheckedLabel.image   = optionsDataMap.isSelected ? UIImage(named: "radioButtonSelected") : UIImage(named: "radioButtonUnselected")
        }
    }
}
