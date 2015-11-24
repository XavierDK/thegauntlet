//
//  LevelComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit
import ObjectMapper


enum ComponentType: Int {
  
  case Start = 0
  case End = 1
  case Wall = 2
  case BasicBloc = 3
  case BasicGauntlet = 4
}


enum ComponentAngle: Int {
  
  case Top = 180
  case Right = 90
  case Bottom = 0
  case Left = 270
}


struct ComponentPosition: Mappable {
  
  var x: Int!
  var y: Int!
  var z: Int!
  
  init?(_ map: Map) {
  }
  
  mutating func mapping(map: Map) {
    
    x <- map["x"]
    y <- map["y"]
    z <- map["z"]    
  }
}


struct LevelComponent: Mappable {
  
  var type: ComponentType!
  var position: ComponentPosition!
  var angle: ComponentAngle!
  
  init?(_ map: Map) {
  }
  
  mutating func mapping(map: Map) {
    
    let typeTransform = TransformOf<ComponentType, Int>(fromJSON: { (value: Int?) -> ComponentType? in
      if let value = value {
        return ComponentType(rawValue: value)
      }
      return nil
      }, toJSON: { (value: ComponentType?) -> Int? in
        if let value = value {
          return value.rawValue
        }
        return nil
    })
    type <- (map["type"], typeTransform)
    
    let angleTransform = TransformOf<ComponentAngle, Int>(fromJSON: { (value: Int?) -> ComponentAngle? in
      if let value = value {
        return ComponentAngle(rawValue: value)
      }
      return nil
      }, toJSON: { (value: ComponentAngle?) -> Int? in
        if let value = value {
          return value.rawValue
        }
        return nil
    })
    angle <- (map["angle"], angleTransform)
    
    position <- map["position"]
  }
}