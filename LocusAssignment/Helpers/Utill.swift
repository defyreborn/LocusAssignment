//
//  Utill.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import Foundation
import UIKit

class Utill : NSObject {
    
    class func loadImage(fileUrl : URL?) -> UIImage? {
        guard let url = fileUrl else {return nil}
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print("error while loading image : \(error)")
        }
        return nil
    }
    
}


