//
//  Boulder.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 23/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class Boulder: GKEntity {
  
  init(component: ElementModel, spriteNode: SKSpriteNode?, actionsManager: ActionsManager, gridManager: GridManager) {
    super.init()
    
    guard let node = spriteNode else {
      fatalError("SpriteNode is empty")
    }
    
    let spriteComponent = SpriteComponent(spriteNode: node)
    addComponent(spriteComponent)
    
    let gridComponent = GridComponent(gridManager: gridManager, x: component.position.x, y: component.position.y)
    addComponent(gridComponent)
    
    let colliderComponent = ColliderComponent()
    addComponent(colliderComponent)
    
    let pushableComponent = PushableComponent(actionsManager: actionsManager)
    addComponent(pushableComponent)
  }
}