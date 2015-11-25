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
  let gridManager: GridManager
  
  let rotateDuration = 0.1
  let moveDuration = 0.30
  
  
  init(actionManager: ActionsManager, gridManager: GridManager) {
    
    self.actionManager = actionManager
    self.gridManager = gridManager
    
    super.init()
  }
  
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    
    guard let entity = entity else {
      return
    }
    guard let spriteComponent = entity.componentForClass(SpriteComponent.self) else {
      return
    }
    
    while let action = self.actionManager.nextMoveAction() {
      switch action {
      case .ActionDownMove:
        if self.gridManager.moveEntity(entity, direction: .Down) {
          self.moveSpriteNode(0, x: 0, y: -spriteComponent.node.size.height, spriteNode: spriteComponent.node)
        }
        else {
          self.rotateSpriteNode(0, spriteNode: spriteComponent.node)
        }
        
      case .ActionLeftMove:
        if self.gridManager.moveEntity(entity, direction: .Left) {
          self.moveSpriteNode(270, x: -spriteComponent.node.size.height, y: 0, spriteNode: spriteComponent.node)
        }
        else {
          self.rotateSpriteNode(270, spriteNode: spriteComponent.node)
        }
        
      case .ActionUpMove:
        if self.gridManager.moveEntity(entity, direction: .Up) {
          self.moveSpriteNode(180, x: 0, y: spriteComponent.node.size.height, spriteNode: spriteComponent.node)
        }
        else {
          self.rotateSpriteNode(180, spriteNode: spriteComponent.node)
        }
        
      case .ActionRightMove:
        if self.gridManager.moveEntity(entity, direction: .Right) {
          self.moveSpriteNode(90, x: spriteComponent.node.size.height, y: 0, spriteNode: spriteComponent.node)
        }
        else {
          self.rotateSpriteNode(90, spriteNode: spriteComponent.node)
        }
        
      default:
        break
      }
      
    }
  }
  
  
  func moveSpriteNode(angle: CGFloat, x: CGFloat, y: CGFloat, spriteNode: SKSpriteNode) {
    
    let bestAngle = MoveComponent.bestAngleForAngle(angle, spriteNode: spriteNode)
    
    let actionMove = SKAction.moveByX(x, y: y, duration: moveDuration)
    actionMove.timingMode = .EaseInEaseOut
    let actionsToLaunch = self.actionManager.actionsToLauch()
    
    let actionBlock = SKAction.runBlock { () -> Void in
      
      for actionToLaunch in actionsToLaunch {
        actionToLaunch.node.runAction(actionToLaunch.action)
      }
      
//      spriteNode
      spriteNode.runAction(actionMove)
      
      self.actionManager.clearActionsToLauch()
    }
    
    if bestAngle != 0 {
      let actionRotate = SKAction.rotateByAngle(bestAngle * CGFloat(M_PI) / 180, duration: rotateDuration)
      spriteNode.runAction(SKAction.sequence([actionRotate, actionBlock]))
    }
      
    else {
      spriteNode.runAction(actionBlock)
    }
  }
  
  
  func rotateSpriteNode(angle: CGFloat, spriteNode: SKSpriteNode) {
    
    let bestAngle = MoveComponent.bestAngleForAngle(angle, spriteNode: spriteNode)
    
    if bestAngle != 0 {
      let actionRotate = SKAction.rotateByAngle(bestAngle * CGFloat(M_PI) / 180, duration: rotateDuration)
      
      spriteNode.runAction(SKAction.sequence([actionRotate]))
    }
  }
  
  
  class func bestAngleForAngle(angle: CGFloat, spriteNode: SKSpriteNode) -> CGFloat {
    
    let angleNode = round(spriteNode.zRotation * 180 / CGFloat(M_PI))
    
    var angle = (angleNode - angle) * -1
    
    angle = round(angle) % 360
    
    if abs(angle) == 270.0 {
      var direction = 1
      if (angle > 0) {
        direction = -1
      }
      angle = CGFloat(90 * direction)
    }
    
    //    print(angle)
    return angle
  }
  
}
