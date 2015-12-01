//
//  LevelSizeModel.swift
//  LevelHandler
//
//  Created by jeff on 01/12/2015.
//  Copyright © 2015 jeff. All rights reserved.
//

import Foundation
import ObjectMapper

struct LevelSizeModel {
    var width : Int!
    var height : Int!
}

extension LevelSizeModel : Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        width <- map["width"]
        height <- map["height"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}


extension LevelSizeModel : CustomDebugStringConvertible {
    var debugDescription: String {
        var output : String = String()
        output.appendContentsOf("width: \(self.width), ")
        output.appendContentsOf("height: \(self.height)")
        return output
    }
}
