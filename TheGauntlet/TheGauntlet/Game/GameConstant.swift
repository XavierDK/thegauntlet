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
    
    static let Margin: Int = 1
    static let Zoom: CGFloat = 60
    static let MinZoom: CGFloat = 40
    static let MaxZoom: CGFloat = 80
  }
    
  struct Sprites {    
    static let Player: String = "player1"
    static let Grid: String = "square"
  }
  
  struct Player {
    
    struct Actions {
      
      static let MaxStackActions: Int = 3
    }
  }
}