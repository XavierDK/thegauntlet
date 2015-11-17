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
  
  init(spriteNode: SKSpriteNode?, entityManager: EntityManager, actionsManager: ActionsManager) {
    super.init()
    
    guard let node = spriteNode else {
      fatalError("SpriteNode is empty")
    }
    
    let spriteComponent = SpriteComponent(spriteNode: node)
    addComponent(spriteComponent)
    
    let moveComponent = MoveComponent(actionManager: actionsManager)
    addComponent(moveComponent)
  }
  
  
}