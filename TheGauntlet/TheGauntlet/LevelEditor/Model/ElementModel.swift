//
//  ElementModel.swift
//  LevelHandler
//
//  Created by jeff on 01/12/2015.
//  Copyright © 2015 jeff. All rights reserved.
//

import Foundation
import ObjectMapper

struct ElementModel {
    var basetype : Int!
    var specifictype : Int!
    var action : ActionableActionModel?
    var position : PositionModel!
}

extension ElementModel : Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        basetype <- map["basetype"]
        specifictype <- map["specifictype"]
        position <- map["position"]
        action <- map["action"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}


extension ElementModel : CustomDebugStringConvertible {
    var debugDescription: String {
        var output : String = String()
        output.appendContentsOf("basetype: \(self.basetype), ")
        output.appendContentsOf("specifictype: \(self.specifictype), ")
        output.appendContentsOf("position: { \(self.position.debugDescription) }, ")
        output.appendContentsOf("action: \(self.action.debugDescription)")
        return output
    }
}
