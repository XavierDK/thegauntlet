//
//  CaseEntity.swift
//  TheGauntlet
//
//  Created by jeff on 02/12/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class CaseEntity: GKEntity {
  
  init(component: ElementModel, spriteNode: SKSpriteNode?) {
    super.init()
    
    guard let node = spriteNode else {
      fatalError("SpriteNode is empty")
    }
    
    let spriteComponent = SpriteComponent(spriteNode: node)
    addComponent(spriteComponent)
  }
}