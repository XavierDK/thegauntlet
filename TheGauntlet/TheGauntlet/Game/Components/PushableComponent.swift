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
  
  let moveDuration = 0.15
  
  override init() {
    super.init()
  }
  
  func push(direction: GridDirection) {
    
    if let spriteComponent = self.entity?.componentForClass(SpriteComponent.self) {
      
      switch direction {
      case .Up:
        self.move(spriteComponent, x: 0, y: spriteComponent.node.size.height)
      case .Down:
        self.move(spriteComponent, x: 0, y: -spriteComponent.node.size.height)
      case .Left:
        self.move(spriteComponent, x: spriteComponent.node.size.width, y: 0)
      case .Right:
        self.move(spriteComponent, x: spriteComponent.node.size.width, y: 0)
      }
    }
  }
  
  func move(spriteComponent: SpriteComponent, x: CGFloat, y: CGFloat) {
    
    let actionMove = SKAction.moveByX(x, y: y, duration: moveDuration)
    actionMove.timingMode = .EaseInEaseOut
    
    spriteComponent.node.runAction(actionMove)
  }
}