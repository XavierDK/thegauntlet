//
//  LevelObject.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit
import ObjectMapper

struct LevelSize: Mappable {
  
  var width: Int!
  var height: Int!
  
  init?(_ map: Map) {
  }
  
  mutating func mapping(map: Map) {
    
    width <- map["width"]
    height <- map["height"]
  }
}

struct LevelObject: Mappable {
  
  var name: String!
  var size: LevelSize!
  var components: [LevelComponent]!
  
  init?(_ map: Map) {
  }
  
  mutating func mapping(map: Map) {
    
    name        <- map["name"]
    size        <- map["size"]
    components  <- map["components"]
  }
}