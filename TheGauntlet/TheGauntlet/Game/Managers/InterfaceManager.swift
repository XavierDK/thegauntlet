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
  
  let camera: SKCameraNode
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
    
    self.camera = SKCameraNode()
    self.camera.xScale = GameConstant.Entity.Size / GameConstant.Level.Zoom
    self.camera.yScale = GameConstant.Entity.Size / GameConstant.Level.Zoom
  }
  
  
  // MARK: Camera
  
  func updatePositionForPosition(position: CGPoint, andIsAction isAction: Bool = true) {
    
    let halfCamX: CGFloat = (UIScreen.mainScreen().bounds.size.width / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    let halfCamY: CGFloat = (UIScreen.mainScreen().bounds.size.height / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    
    let playerX: CGFloat = position.x / GameConstant.Entity.Size
    let playerY: CGFloat = position.y / GameConstant.Entity.Size
    
    var posX: CGFloat = position.x
    var posY: CGFloat = position.y
    
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
    
    if isAction {
      self.camera.runAction(SKAction.moveTo(CGPoint(x:posX, y: posY), duration: 0.15))
    }
    else {
      self.camera.position = CGPoint(x:posX, y: posY)
    }
  }
  
  func moveCameraForTouches(touches: Set<UITouch>) {
    
    let location: CGPoint = self.middleLocationForTouches(touches)
    
    if self.lastLocation != CGPointZero && location != CGPointZero {
      let posX: CGFloat = self.camera.position.x + self.lastLocation.x - location.x
      let posY: CGFloat = self.camera.position.y + (self.lastLocation.y - location.y)
      
      self.updatePositionForPosition(CGPoint(x: posX, y: posY), andIsAction: false)
      
//      self.camera.position = CGPoint(x: posX, y: posY)
    }
    
    self.lastLocation = location
  }
  
  func middleLocationForTouches(var touches: Set<UITouch>) -> CGPoint {
    
    let firstTouch = touches.popFirst()
    let secondTouch = touches.popFirst()
    
    if let firstTouch = firstTouch,
      let secondTouch = secondTouch {
        
        let firstLocation = firstTouch.locationInNode(self.camera)
        let secondLocation = secondTouch.locationInNode(self.camera)
        
        return CGPoint(x: (firstLocation.x + secondLocation.x) / 2 * 1.5, y: (firstLocation.y + secondLocation.y) / 2 * 1.5)
    }
    
    return CGPointZero
  }
  
  func resetCamera() {

    self.lastLocation = CGPointZero
  }
}