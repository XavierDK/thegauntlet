//
//  ActionableActionModel.swift
//  LevelHandler
//
//  Created by jeff on 01/12/2015.
//  Copyright © 2015 jeff. All rights reserved.
//

import Foundation
import ObjectMapper

struct ActionableActionModel {
    var action : ActionableActionType!
    var block : SpecificTypeBlock!
    var position : PositionModel!
}

extension ActionableActionModel : Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        action <- map["action"]
        block <- map["block"]
        position <- map["position"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}

extension ActionableActionModel : CustomDebugStringConvertible {
    var debugDescription: String {
        var output : String = String()
        output.appendContentsOf("action: \(self.action), ")
        output.appendContentsOf("block: \(self.block), ")
        output.appendContentsOf("position: { \(self.position.debugDescription) }")
        return output
    }
}

