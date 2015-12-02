//
//  Player.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
  
  init(component: ElementModel, spriteNode: SKSpriteNode?, actionsManager: ActionsManager, gridManager: GridManager) {
    super.init()

    guard let node = spriteNode else {
      fatalError("SpriteNode is empty")
    }
    
    let spriteComponent = SpriteComponent(spriteNode: node)
    addComponent(spriteComponent)
    
    let gridComponent = GridComponent(gridManager: gridManager, x: component.position.x, y: component.position.y)
    addComponent(gridComponent)
    
    let moveComponent = MoveComponent(actionManager: actionsManager, gridManager: gridManager)
    addComponent(moveComponent)
    
    let inventoryComponent = InventoryComponent()
    addComponent(inventoryComponent)
  }
}