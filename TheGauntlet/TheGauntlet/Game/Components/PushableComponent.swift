//
//  PushableComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 24/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class PushableComponent: GKComponent {
  
  let actionsManager: ActionsManager
  
  init(actionsManager: ActionsManager) {
    
    self.actionsManager = actionsManager
    super.init()
  }
  
  func push(direction: ComponentDirection) {
    
    if let spriteComponent = self.entity?.componentForClass(SpriteComponent.self) {
      
      switch direction {
      case .Up:
        self.move(spriteComponent, x: 0, y: GameConstant.Entity.Size)
      case .Down:
        self.move(spriteComponent, x: 0, y: -GameConstant.Entity.Size)
      case .Left:
        self.move(spriteComponent, x: -GameConstant.Entity.Size, y: 0)
      case .Right:
        self.move(spriteComponent, x: GameConstant.Entity.Size, y: 0)
      }
    }
  }
  
  func move(spriteComponent: SpriteComponent, x: CGFloat, y: CGFloat) {
    
    let actionMove = SKAction.moveByX(x, y: y, duration: GameConstant.Entity.MoveDuration)
    actionMove.timingMode = .EaseInEaseOut
    
    self.actionsManager.addActionToLaunch(actionMove, forNode: spriteComponent.node)
    
//    spriteComponent.node.runAction(actionMove)
  }
}