//
//  SpriteComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
  
  let node: SKSpriteNode
  
  init(texture: SKTexture) {
    node = SKSpriteNode(texture: texture, color: SKColor.whiteColor(), size: texture.size())    
    super.init()
  }
  
  init(spriteNode: SKSpriteNode) {
    self.node = spriteNode
    super.init()    
  }
}