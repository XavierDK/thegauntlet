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
  
  init(levelSize: LevelSize) {
    
    self.levelSize = levelSize
    
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
  
  func updatePositionForNode(node: SKSpriteNode) {
    
//    print(node.position.x / GameConstant.Entity.Size)
    
    let halphCamX: CGFloat = (UIScreen.mainScreen().bounds.size.width / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    let halphCamY: CGFloat = (UIScreen.mainScreen().bounds.size.height / GameConstant.Entity.Size / 2) * (GameConstant.Entity.Size / GameConstant.Level.Zoom)
    
//    UIScreen.mainScreen().bounds.size.width
    
    print(halphCamY)
    
    let playerX: CGFloat = node.position.x / GameConstant.Entity.Size
    let playerY: CGFloat = node.position.y / GameConstant.Entity.Size
//
//    print(playerX - 0.5 - CGFloat(GameConstant.Level.Margin))
    
    
    var posX: CGFloat = node.position.x
    var posY: CGFloat = node.position.y
    
    if playerX - halphCamX  < 0 {
      posX = halphCamX * GameConstant.Entity.Size
    }
    
    if playerX + halphCamX  > CGFloat(self.levelSize.width) + 2 * CGFloat(GameConstant.Level.Margin) {
      posX = (CGFloat(self.levelSize.width) + 2 * CGFloat(GameConstant.Level.Margin) - halphCamX) * GameConstant.Entity.Size
    }
    
    if playerY - halphCamY  < 0 {
      posY = halphCamY * GameConstant.Entity.Size
    }
    
    if playerY + halphCamY  > CGFloat(self.levelSize.height) + 2 * CGFloat(GameConstant.Level.Margin) {
      posY = (CGFloat(self.levelSize.height) + 2 * CGFloat(GameConstant.Level.Margin) - halphCamY) * GameConstant.Entity.Size
    }

    if CGFloat(self.levelSize.width) < halphCamX * 2 {
      posX = (halphCamX + CGFloat(GameConstant.Level.Margin) / 2) * GameConstant.Entity.Size
    }

    if CGFloat(self.levelSize.height) < halphCamY * 2 {
      posY = (halphCamY + CGFloat(GameConstant.Level.Margin) / 2) * GameConstant.Entity.Size
    }

    self.sceneCamera.position = CGPoint(x:posX, y: posY)
  }
}