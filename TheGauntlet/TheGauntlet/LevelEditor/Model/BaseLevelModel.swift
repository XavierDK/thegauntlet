//
//  BaseLevelModel.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseLevelModel {
    var name : String!
    var levelFilename : String!
    var image : BaseImageModel!
    var position : PositionModel!
}

extension BaseLevelModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        name  <- map["name"]
        levelFilename  <- map["levelFilename"]
        image  <- map["image"]
        position  <- map["position"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
    
}

extension BaseLevelModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("\n{ name: \(self.name), ")
        output.appendContentsOf("levelFilename: \(self.levelFilename), ")
        output.appendContentsOf("image: { \(self.image.debugDescription) }, ")
        output.appendContentsOf("position: { \(self.position.debugDescription) } }")
        return output
    }
}
