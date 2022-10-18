//
//  TableView+Extension.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import Foundation
import UIKit


extension UITableViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}

extension UITableView {
    func registerAndGet<T:UITableViewCell>(cell identifier:T.Type) -> T?{
        let cellID = String(describing: identifier)
        if let cell = self.dequeueReusableCell(withIdentifier: cellID) as? T {
            return cell
        } else {
            self.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
            return self.dequeueReusableCell(withIdentifier: cellID) as? T
            
        }
    }
}
