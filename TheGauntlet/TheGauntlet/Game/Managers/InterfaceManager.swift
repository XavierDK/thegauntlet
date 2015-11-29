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
    
    self.sceneCamera = SKCameraNode()
   // self.addChild(self.sceneCamera)
    self.sceneCamera.xScale = 0.4
    self.sceneCamera.yScale = 0.4
//    self.scene?.scaleMode = .AspectFit
    //self.camera = self.sceneCamera
  }
}