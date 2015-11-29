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
  
  init(levelSize: LevelSize) {
    
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
}