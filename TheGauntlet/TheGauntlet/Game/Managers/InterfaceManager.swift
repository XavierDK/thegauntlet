//
//  InterfaceManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 28/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class InterfaceManager {
  
  let sceneCamera: SKCameraNode
  let levelSize: LevelSize
  var lastLocation: CGPoint
  
  init(levelSize: LevelSize) {
    
    self.levelSize = levelSize
    self.lastLocation = CGPointZero
    
    //    let lbl: SKLabelNode = SKLabelNode(fontNamed: "Arial")
    //    lbl.text = "Drag this label"
    //    lbl.fontSize = 5
    //    lbl.fontColor = UIColor.blackColor()
    //    lbl.position = CGPointMake(0, 0)
    //    lbl.zPosition = 99
    //    self.sceneCamera.addChild(lbl)
    
    self.sceneCamera = SKCameraNode()
    self.sceneCamera.xScale = GameConstant.Entity.Size / GameConstant.Level.Zoom
    self.sceneCamera.yScale = GameConstant.Entity.Size / GameConstant.Level.Zoom
  }
  
  
  // MARK: Camera
  
  func updatePositionForNode(node: SKSpriteNode) {
    
    let halfCamX: CGFloat = (UIScreen.mainScreen().bounds.size.width / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    let halfCamY: CGFloat = (UIScreen.mainScreen().bounds.size.height / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    
    let playerX: CGFloat = node.position.x / GameConstant.Entity.Size
    let playerY: CGFloat = node.position.y / GameConstant.Entity.Size
    
    var posX: CGFloat = node.position.x
    var posY: CGFloat = node.position.y
    
    if playerX - halfCamX  < 0 {
      posX = halfCamX * GameConstant.Entity.Size
    }
    
    if playerX + halfCamX  > CGFloat(self.levelSize.width) + 2 * CGFloat(GameConstant.Level.Margin) {
      posX = (CGFloat(self.levelSize.width) + 2 * CGFloat(GameConstant.Level.Margin) - halfCamX) * GameConstant.Entity.Size
    }
    
    if playerY - halfCamY  < 0 {
      posY = halfCamY * GameConstant.Entity.Size
    }
    
    if playerY + halfCamY  > CGFloat(self.levelSize.height) + 2 * CGFloat(GameConstant.Level.Margin) {
      posY = (CGFloat(self.levelSize.height) + 2 * CGFloat(GameConstant.Level.Margin) - halfCamY) * GameConstant.Entity.Size
    }
    
    if CGFloat(self.levelSize.width) < halfCamX * 2 {
      posX = (CGFloat(self.levelSize.width) / 2 + CGFloat(GameConstant.Level.Margin)) * GameConstant.Entity.Size
    }
    
    if CGFloat(self.levelSize.height) < halfCamY * 2 {
      posY = (CGFloat(self.levelSize.height) / 2 + CGFloat(GameConstant.Level.Margin)) * GameConstant.Entity.Size
    }
    
    self.sceneCamera.position = CGPoint(x:posX, y: posY)
  }
  
  func moveCameraForTouches(touches: Set<UITouch>) {
    
    let location: CGPoint = self.middleLocationForTouches(touches)
    
    if self.lastLocation != CGPointZero && location != CGPointZero {
      let posX: CGFloat = self.sceneCamera.position.x + self.lastLocation.x - location.x
      let posY: CGFloat = self.sceneCamera.position.y - (self.lastLocation.y - location.y)
      self.sceneCamera.position = CGPoint(x: posX, y: posY)
    }
    
    self.lastLocation = location
  }
  
  func middleLocationForTouches(var touches: Set<UITouch>) -> CGPoint {
    
    let firstTouch = touches.popFirst()
    let secondTouch = touches.popFirst()
    
    if let firstTouch = firstTouch,
      let secondTouch = secondTouch {
        
        let firstLocation = firstTouch.locationInNode(self.sceneCamera)
        let secondLocation = secondTouch.locationInNode(self.sceneCamera)
        
        return CGPoint(x: (firstLocation.x + secondLocation.x) / 2 * 1.5, y: (firstLocation.y + secondLocation.y) / 2 * 1.5)
    }
    
    return CGPointZero
  }
  
  func resetMovingCamera() {
    
    self.lastLocation = CGPointZero
  }
}