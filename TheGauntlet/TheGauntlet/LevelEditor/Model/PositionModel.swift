//
//  PositionModel.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct PositionModel {
    var x : Int!
    var y : Int!
    var z : Int!
    var orientation : Orientation!
}

extension PositionModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        x  <- map["x"]
        y  <- map["y"]
        z  <- map["z"]
        orientation  <- map["orientation"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}


extension PositionModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("x: \(self.x), ")
        output.appendContentsOf("y: \(self.y), ")
        output.appendContentsOf("z: \(self.z), ")
        output.appendContentsOf("orientation: \(self.orientation)")
        return output
    }
}
