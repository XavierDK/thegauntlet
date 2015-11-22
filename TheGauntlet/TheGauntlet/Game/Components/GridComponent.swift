//
//  GridComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 22/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class GridComponent: GKComponent {
  
  var x: Int
  var y: Int
  var isOnGrid: Bool
  let gridManager: GridManager
  
  init(gridManager: GridManager, x: Int, y: Int) {
    
    self.isOnGrid = false
    self.gridManager = gridManager
    self.x = x
    self.y = y
    
    super.init()
  }
}