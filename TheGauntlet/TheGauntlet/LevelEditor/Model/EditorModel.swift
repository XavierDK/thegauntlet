//
//  EditorModel.swift
//  LevelHandler
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 jeff. All rights reserved.
//

import Foundation
import ObjectMapper

struct EditorModel {
    var version : String!
    var name : String!
}

extension EditorModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        version <- map["version"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}


extension EditorModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("name: \(self.name), ")
        output.appendContentsOf("version: \(self.version)")
        return output
    }
}

