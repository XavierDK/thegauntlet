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
  let levelSize: LevelSizeModel
  var lastLocation: CGPoint
  var actualZoom: CGFloat
  var temporaryZoom: CGFloat
  
  init(levelSize: LevelSizeModel) {
    
    self.levelSize = levelSize
    self.lastLocation = CGPointZero
    self.actualZoom = GameConstant.Level.Zoom
    self.temporaryZoom = self.actualZoom
    
    //    let lbl: SKLabelNode = SKLabelNode(fontNamed: "Arial")
    //    lbl.text = "Drag this label"
    //    lbl.fontSize = 5
    //    lbl.fontColor = UIColor.blackColor()
    //    lbl.position = CGPointMake(0, 0)
    //    lbl.zPosition = 99
    //    self.sceneCamera.addChild(lbl)
    
    self.camera = SKCameraNode()
    self.camera.xScale = GameConstant.Entity.Size / self.actualZoom
    self.camera.yScale = GameConstant.Entity.Size / self.actualZoom
  }
  
  
  // MARK: Camera
  
  func updatePositionForPosition(position: CGPoint, andIsAction isAction: Bool = true, andDuration duration: NSTimeInterval = 0.15) {
    
    let halfCamX: CGFloat = (UIScreen.mainScreen().bounds.size.width / GameConstant.Entity.Size / 2) * self.camera.xScale
    let halfCamY: CGFloat = (UIScreen.mainScreen().bounds.size.height / GameConstant.Entity.Size / 2) * self.camera.yScale
    
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
      self.camera.runAction(SKAction.moveTo(CGPoint(x:posX, y: posY), duration: duration))
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
        
        return CGPoint(x: (firstLocation.x + secondLocation.x) / 2, y: (firstLocation.y + secondLocation.y) / 2)
    }
    
    return CGPointZero
  }
  
  func resetCamera() {

    self.lastLocation = CGPointZero
  }
  
  func updateZoomForScale(scale: CGFloat) {
    
    self.temporaryZoom = self.actualZoom * scale
    
    if self.temporaryZoom < GameConstant.Level.MinZoom {
      self.temporaryZoom = GameConstant.Level.MinZoom
    }
    
    if self.temporaryZoom > GameConstant.Level.MaxZoom {
      self.temporaryZoom = GameConstant.Level.MaxZoom
    }
    
    self.camera.xScale = GameConstant.Entity.Size / self.temporaryZoom
    self.camera.yScale = GameConstant.Entity.Size / self.temporaryZoom
  }
  
  func endUpdateZoom() {
    self.actualZoom = self.temporaryZoom
  }
}