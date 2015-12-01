//
//  WorldModel.swift
//  LevelGenerator
//
//  Created by jeff on 27/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct WorldModel {
    var name : String!
    var backgroundImage : BaseImageModel!
    var levels : [BaseLevelModel]!
    var soundID : Int!
    var creator : CreatorModel!
    var editor : EditorModel!
    var created : String!
    var updated : String!
}

extension WorldModel : Mappable {
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        backgroundImage <- map["backgroundImage"]
        levels <- map["levels"]
        soundID <- map["soundID"]
        creator <- map["creator"]
        created <- map["created"]
        updated <- map["updated"]
        editor <- map["editor"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}

extension WorldModel : JSONModelParser { }

extension WorldModel : CustomDebugStringConvertible {
    var debugDescription : String {
        var output : String = String()
        output.appendContentsOf("{\n\t- name: \(self.name)\n")
        output.appendContentsOf("\t- soundID: \(self.soundID)\n")
        output.appendContentsOf("\t- created: \(self.created)\n")
        output.appendContentsOf("\t- updated: \(self.updated)\n")
        output.appendContentsOf("\t- creator: { \(self.creator.debugDescription) }\n")
        output.appendContentsOf("\t- editor: { \(self.editor.debugDescription) }\n")
        output.appendContentsOf("\t- backgroundImage: { \(self.backgroundImage.debugDescription) }\n")
        output.appendContentsOf("\t- levels: \(self.levels)\n }")
        return output
    }
}

