//
//  DemoModel.swift
//  LocusAssignment
//
//  Created by Mubashshir on 10/18/22.
//

import Foundation

class DemoModel : NSObject {
    
    enum MediaType : String {
        case photo          = "PHOTO"
        case singleChoice   = "SINGLE_CHOICE"
        case comment        = "COMMENT"
    }
    
    var mediaType           : MediaType       = .photo
    var id                  : String          = ""
    var title               : String          = ""
    var optionsDataMap      : [OptionsDataMap] = []
    var photoLocation       = URL(string: "")
    var isPhotoSelected     : Bool = false
    var isCommentEnabled    : Bool = false
    var didUserResponded    : Bool = false
    
    init(_ aDict : JSON) {
        
        mediaType   = MediaType.init(rawValue: aDict["type"].stringValue) ?? .photo
        id          = aDict["id"].stringValue
        title       = aDict["title"].stringValue
        switch mediaType {
        case .photo :
            break
        case .comment :
            break
        case .singleChoice :
            for (key,_) in aDict["dataMap"].dictionaryValue {
                optionsDataMap = aDict["dataMap"][key].arrayValue.map({OptionsDataMap.init(optionText: $0.stringValue)})
            }
        }
    }
}

class OptionsDataMap {
    
    var option : String = ""
    var isSelected : Bool = false
    
    init(optionText: String) {
        self.option = optionText
    }
}
