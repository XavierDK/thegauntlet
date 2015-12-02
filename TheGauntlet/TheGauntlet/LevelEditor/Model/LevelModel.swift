//
//  LevelModel.swift
//  LevelGenerator
//
//  Created by Jeffrey Macko on 19/11/15.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

struct LevelModel {
    var soundId : Int!
    var worldId : Int!
    var created : String!
    var updated : String!
    
    var baseLevelModel : BaseLevelModel!
    var backgroundImage : BaseImageModel!
    var creator : CreatorModel!
    var editor : EditorModel!
    var size : LevelSizeModel!
    
    var elements : [ElementModel]!
    
    func elementAtPosition(idx: PositionModel) -> ElementModel? {
        for anElement in self.elements {
            if anElement.position.x == idx.x && anElement.position.y == idx.y {
                return anElement
            }
        }
        return nil
    }
}

// Rend le fichier parsable
extension LevelModel : JSONModelParser { }

// Parse le fichier
extension LevelModel : Mappable {
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        soundId <- map["soundId"]
        worldId <- map["worldId"]
        created <- map["created"]
        updated <- map["updated"]
        baseLevelModel <- map["baseLevelModel"]
        backgroundImage <- map["backgroundImage"]
        creator <- map["creator"]
        editor <- map["editor"]
        size <- map["size"]
        elements <- map["elements"]
    }
    
    func checkMappedDataValidity() throws -> Bool {
        return true
    }
}

// Debug String
extension LevelModel : CustomDebugStringConvertible {
    var debugDescription: String {
        var output : String = String()
        output.appendContentsOf("--------------------\n")
        output.appendContentsOf("soundId: \(self.soundId)\n")
        output.appendContentsOf("worldId: \(self.worldId)\n")
        output.appendContentsOf("created: \(self.created)\n")
        output.appendContentsOf("updated: \(self.updated)\n")
        output.appendContentsOf("baseLevelModel: { \(self.baseLevelModel.debugDescription) }\n")
        output.appendContentsOf("backgroundImage: { \(self.backgroundImage.debugDescription) }\n")
        output.appendContentsOf("creator: { \(self.creator.debugDescription) }\n")
        output.appendContentsOf("editor: { \(self.editor.debugDescription) }\n")
        output.appendContentsOf("size: { \(self.size.debugDescription) }\n")
        output.appendContentsOf("elements: { \(self.elements.debugDescription) }\n")
        output.appendContentsOf("--------------------\n\n")
        
        var w : Int, h : Int = 0
        while h < self.size.height {
            w = 0
            while w < self.size.width {
                if let anElement : ElementModel = self.elementAtPosition(PositionModel(x: w, y: h, z: 0, orientation: Orientation.Right)) {
                    let basetype = BaseType(rawValue: anElement.basetype)!
                    switch basetype {
                    case BaseType.User:
                        let specifictype = SpecificTypeUser(rawValue: anElement.specifictype)!
                        switch specifictype {
                        case SpecificTypeUser.In:
                            output.appendContentsOf("I")
                            break
                        case SpecificTypeUser.Out:
                            output.appendContentsOf("O")
                            break
                        }
                        break
                    case BaseType.Case:
                        let specifictype = SpecificTypeCase(rawValue: anElement.specifictype)!
                        switch specifictype {
                        case SpecificTypeCase.Simple, SpecificTypeCase.Hole, SpecificTypeCase.Muddy, SpecificTypeCase.Ephemeral, SpecificTypeCase.Actionable:
                            output.appendContentsOf("@")
                            break
                        }
                        break;
                    case BaseType.Block:
                        let specifictype = SpecificTypeBlock(rawValue: anElement.specifictype)!
                        switch specifictype {
                        case SpecificTypeBlock.Boulder, SpecificTypeBlock.BoulderCracked, SpecificTypeBlock.Tree, SpecificTypeBlock.BurningTree:
                            output.appendContentsOf("#")
                            break
                        case SpecificTypeBlock.Wall:
                            output.appendContentsOf("*")
                            break
                        }
                        break;
                    case BaseType.Item:
                        let specifictype = SpecificTypeItem(rawValue: anElement.specifictype)!
                        switch specifictype {
                        case SpecificTypeItem.Rope, SpecificTypeBlock.Hammer, SpecificTypeBlock.Axe, SpecificTypeBlock.WaterSeal:
                            output.appendContentsOf("H")
                            break
                        case SpecificTypeBlock.Glove:
                            output.appendContentsOf("G")
                            break
                        }
                        break;
                    }
                }
                else {
                    output.appendContentsOf("-")
                }
                w++
            }
            output.appendContentsOf("\n")
            h++
        }
        return output
    }
}