//
//  Muddy.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 08/12/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class Muddy: GKEntity {
  
  init(component: ElementModel, spriteNode: SKSpriteNode?, gridManager: GridManager) {
    super.init()
    
    guard let node = spriteNode else {
      fatalError("SpriteNode is empty")
    }
    
    let spriteComponent = SpriteComponent(spriteNode: node)
    addComponent(spriteComponent)
    
    let gridComponent = GridComponent(gridManager: gridManager, x: component.position.x, y: component.position.y)
    addComponent(gridComponent)
    
    let slipComponent = SlipComponent()
    addComponent(slipComponent)
  }
}