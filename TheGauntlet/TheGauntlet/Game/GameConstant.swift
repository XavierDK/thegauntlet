//
//  GameConstant.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 29/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit

struct GameConstant {
  
  struct Debug {
    
    static let Enable: Bool = true
  }
  
  struct Entity {
    
    static let Size: CGFloat = 40.0
    static let MoveDuration: Double = 0.25
    static let RotateDuration: Double = 0.1
  }
  
  struct Level {
    
    static let Margin: Int = 2
    static let Zoom: CGFloat = 90
  }
  
  enum Levels: String {
    
    case Level00 = "__LEVEL_00__"
    
    static func levelForIndex(index: Int) -> Levels {
      
      switch index {
      case 0:
        return Level00
      default:
        return Level00
      }
    }
  }
  
  struct Sprites {
    
    static let Player: String = "player1"
    static let Wall: String = "wall"
    static let Block: String = "basic_bloc"
    static let Gauntlet: String = "basic_gauntlet"
    static let Grid: String = "square"
  }
  
  struct Player {
    
    struct Actions {
      
      static let MaxStackActions: Int = 3
      
      static let Move: String = "PlayerMove"
      static let Rotate: String = "PlayerRotate"
    }
  }
}