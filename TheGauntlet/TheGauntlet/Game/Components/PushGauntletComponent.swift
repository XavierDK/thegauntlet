//
//  PushGauntletComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 24/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class PushGauntletComponent: GKComponent, GauntletComponent {
  
  override init() {

    super.init()
  }
  
  func actionForGrid(gridManager: GridManager, newX: Int, newY: Int, direction: GridDirection) -> (Int, Int) {
    
    let res = gridManager.checkComponentClass(PushableComponent.self, newX: newX+1, newY: newY)
    
    if res.0, let pushableEntity = res.1 {
      
      if let pushableComponent = pushableEntity.componentForClass(PushableComponent.self) {
        pushableComponent.push(direction)
      }
    }
    
    return (newX, newY)
  }
}
