//
//  BaseImageModel.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseImageModel {
    var imageId : Int!
    var imageOrientation : Orientation?
}

extension BaseImageModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        imageId  <- map["imageId"]
        imageOrientation  <- map["imageOrientation"]
    }

    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}

extension BaseImageModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("imageId: \(self.imageId), ")
        output.appendContentsOf("imageOrientation: \(self.imageOrientation)")
        return output
    }
}
