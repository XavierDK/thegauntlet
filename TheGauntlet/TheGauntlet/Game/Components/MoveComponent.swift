//
//  MoveComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 17/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class MoveComponent: GKComponent {
  
  let actionManager: ActionsManager
  
  let rotateDuration = 0.2
  let moveDuration = 0.3
  
  init(actionManager: ActionsManager) {
    
    self.actionManager = actionManager
    super.init()
  }
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    
    guard let spriteComponent = entity?.componentForClass(SpriteComponent.self) else {
      return
    }
    
    if let action = self.actionManager.nextMoveAction() {
      switch action {
      case .ActionDownMove:
        self.moveSpriteNode(0, x: 0, y: -spriteComponent.node.size.height, spriteNode: spriteComponent.node)
        
      case .ActionLeftMove:
        self.moveSpriteNode(270, x: -spriteComponent.node.size.height, y: 0, spriteNode: spriteComponent.node)
        
      case .ActionUpMove:
        self.moveSpriteNode(180, x: 0, y: spriteComponent.node.size.height, spriteNode: spriteComponent.node)
        
      case .ActionRightMove:
        self.moveSpriteNode(90, x: spriteComponent.node.size.height, y: 0, spriteNode: spriteComponent.node)
        
      default:
        break
      }
      
    }
  }
  
  func moveSpriteNode(angle: CGFloat, x: CGFloat, y: CGFloat, spriteNode: SKSpriteNode) {
    
    let bestAngle = MoveComponent.bestAngleForAngle(angle, spriteNode: spriteNode)
    let actionRotate = SKAction.rotateByAngle(bestAngle * CGFloat(M_PI) / 180, duration: rotateDuration)
    
    let actionMove = SKAction.moveByX(x, y: y, duration: moveDuration)
    actionMove.timingMode = .EaseInEaseOut
    
    spriteNode.runAction(SKAction.sequence([actionRotate, actionMove]))
  }
  
  class func bestAngleForAngle(angle: CGFloat, spriteNode: SKSpriteNode) -> CGFloat {
    
    let angleNode = round(spriteNode.zRotation * 180 / CGFloat(M_PI))
    
    let angle1 = (angleNode + 360 - angle) * -1
    let angle2 = (angleNode - angle) * -1
    
    return (abs(angle1) < abs(angle2)) ? (angle1) : (angle2)
  }
  
}
