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
  
  func actionForGrid(gridManager: GridManager, newX: Int, newY: Int, direction: Orientation) -> (Int, Int) {
    
    var newObjX: Int = newX
    var newObjY: Int = newY
    
    switch direction {
    case .Up:
      newObjY++
    case .Down:
      newObjY--
    case .Left:
      newObjX--
    case .Right:
      newObjX++
    }
    
    if gridManager.checkLevelLimit(newX, newY: newY) {
      let res = gridManager.checkComponentClass(PushableComponent.self, newX: newX, newY: newY)
      
      if res.0, let pushableEntity = res.1 {
        if gridManager.checkLevelLimit(newObjX, newY: newObjY)
          && !gridManager.checkComponentClass(ColliderComponent.self, newX: newObjX, newY: newObjY).0 {
            
            if let pushableComponent = pushableEntity.componentForClass(PushableComponent.self) {
              
              gridManager.updateEntity(pushableEntity, newX: newObjX, newY: newObjY)
              pushableComponent.push(direction)
            }
        }
      }
    }
    
    return (newX, newY)
  }
}
