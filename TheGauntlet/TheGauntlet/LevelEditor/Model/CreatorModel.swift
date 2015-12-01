//
//  CreatorModel.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct CreatorModel {
    var name : String!
    var twitter : String!
    var youtube : String!
}

extension CreatorModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        name  <- map["name"]
        twitter  <- map["twitter"]
        youtube  <- map["youtube"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
    
}

extension CreatorModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("name: \(self.name), ")
        output.appendContentsOf("twitter: \(self.twitter), ")
        output.appendContentsOf("youtube: \(self.youtube)")
        return output
    }
}
