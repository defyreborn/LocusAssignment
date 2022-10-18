//
//  MCQTableViewCell.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import UIKit

class MCQTableViewCell: UITableViewCell {

    @IBOutlet private weak var questionTitleLabel       : UILabel!
    @IBOutlet private weak var mcqTableView             : UITableView!
    @IBOutlet private weak var mcqTableViewHeightConstraint     : NSLayoutConstraint!
    
    var optionsArray : [OptionsDataMap] = []
    var updateCellBlock     : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(demoModel : DemoModel){
        optionsArray = demoModel.optionsDataMap
        mcqTableViewHeightConstraint.constant = CGFloat(optionsArray.count * 50)
        mcqTableView.delegate = self
        mcqTableView.dataSource = self
        mcqTableView.reloadData()
        questionTitleLabel.text = demoModel.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension MCQTableViewCell : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.registerAndGet(cell: CategoryTableViewCell.self) else { return UITableViewCell() }
        cell.optionsDataMap = optionsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionsArray.map({$0.isSelected = false})
        optionsArray[indexPath.row].isSelected = !optionsArray[indexPath.row].isSelected
        tableView.reloadData()
        updateCellBlock?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
