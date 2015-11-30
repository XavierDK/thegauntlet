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
  
  var lastTime: NSTimeInterval?
  
  init(actionManager: ActionsManager, gridManager: GridManager) {
    
    self.actionManager = actionManager
    self.gridManager = gridManager
    
    super.init()
  }
  
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    
    if let lastTime = self.lastTime {
      if seconds - lastTime < GameConstant.Entity.MoveDuration {
        return
      }
    }
    
    guard let entity = entity else {
      return
    }
    guard let spriteComponent = entity.componentForClass(SpriteComponent.self) else {
      return
    }
    
    if spriteComponent.node.actionForKey(GameConstant.Player.Actions.Move) == nil
    && spriteComponent.node.actionForKey(GameConstant.Player.Actions.Rotate) == nil {
      if let action = self.actionManager.nextMoveAction() {
        switch action {
        case .ActionDownMove:
          if self.gridManager.moveEntity(entity, direction: .Down) {
            self.lastTime = seconds
            self.moveSpriteNode(0, x: 0, y: -GameConstant.Entity.Size, spriteNode: spriteComponent.node)
          }
          else {
            self.rotateSpriteNode(0, spriteNode: spriteComponent.node)
          }
          
        case .ActionLeftMove:
          if self.gridManager.moveEntity(entity, direction: .Left) {
            self.lastTime = seconds
            self.moveSpriteNode(270, x: -GameConstant.Entity.Size, y: 0, spriteNode: spriteComponent.node)
          }
          else {
            self.rotateSpriteNode(270, spriteNode: spriteComponent.node)
          }
          
        case .ActionUpMove:
          if self.gridManager.moveEntity(entity, direction: .Up) {
            self.lastTime = seconds
            self.moveSpriteNode(180, x: 0, y: GameConstant.Entity.Size, spriteNode: spriteComponent.node)
          }
          else {
            self.rotateSpriteNode(180, spriteNode: spriteComponent.node)
          }
          
        case .ActionRightMove:
          if self.gridManager.moveEntity(entity, direction: .Right) {
            self.lastTime = seconds
            self.moveSpriteNode(90, x: GameConstant.Entity.Size, y: 0, spriteNode: spriteComponent.node)
          }
          else {
            self.rotateSpriteNode(90, spriteNode: spriteComponent.node)
          }
          
        default:
          break
        }
      }
    }
  }
  
  
  func moveSpriteNode(angle: CGFloat, x: CGFloat, y: CGFloat, spriteNode: SKSpriteNode) {
    
    let bestAngle = MoveComponent.bestAngleForAngle(angle, spriteNode: spriteNode)
    
    
    // TEST ANIMATION!
    
    var walkFrames = [SKTexture]()
    let playerAnimatedAtlas = SKTextureAtlas(named: "Player")
    
    let numImages = playerAnimatedAtlas.textureNames.count;
    for i in 1 ... numImages/2 {
      let textureName = "player\(i)"
      let texture = playerAnimatedAtlas.textureNamed(textureName)
      walkFrames.append(texture)
    }
    
    let actionAnimate = SKAction.animateWithTextures(walkFrames, timePerFrame: GameConstant.Entity.MoveDuration/Double(walkFrames.count), resize: false, restore: false)
    
    //
    
    let actionMove = SKAction.moveByX(x, y: y, duration: GameConstant.Entity.MoveDuration)
    actionMove.timingMode = .EaseInEaseOut
    let actionsToLaunch = self.actionManager.actionsToLauch()
    
    let actionBlock = SKAction.runBlock { () -> Void in
      
      for actionToLaunch in actionsToLaunch {
        actionToLaunch.node.runAction(actionToLaunch.action)
      }
      
      spriteNode.runAction(actionAnimate)
      spriteNode.runAction(actionMove)
      
      self.actionManager.clearActionsToLauch()
    }
    
    if bestAngle != 0 {
      let rotateDuration = (abs(bestAngle) > 90) ? (GameConstant.Entity.RotateDuration*2) : (GameConstant.Entity.RotateDuration)
      let actionRotate = SKAction.rotateByAngle(bestAngle * CGFloat(M_PI) / 180, duration: rotateDuration)
      spriteNode.runAction(SKAction.sequence([actionRotate, actionBlock]), withKey: GameConstant.Player.Actions.Move)
    }
      
    else {
      spriteNode.runAction(actionBlock, withKey: GameConstant.Player.Actions.Move)
    }
  }
  
  
  func rotateSpriteNode(angle: CGFloat, spriteNode: SKSpriteNode) {
    
    let bestAngle = MoveComponent.bestAngleForAngle(angle, spriteNode: spriteNode)
    
    if bestAngle != 0 {
      
      let rotateDuration = (abs(bestAngle) > 90) ? (GameConstant.Entity.RotateDuration*2) : (GameConstant.Entity.RotateDuration)
      let actionRotate = SKAction.rotateByAngle(bestAngle * CGFloat(M_PI) / 180, duration: rotateDuration)
      
      spriteNode.runAction(SKAction.sequence([actionRotate]), withKey: GameConstant.Player.Actions.Rotate)
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
