//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  var lastUpdateTimeInterval: NSTimeInterval = 0
  
  var gameOver = false
  
  var entityManager: EntityManager!
  
  override func didMoveToView(view: SKView) {
    
    entityManager = EntityManager(scene: self)
    
    let player = Player(spriteNode: self.childNodeWithName("player") as? SKSpriteNode, entityManager: entityManager)
    entityManager.add(player)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
  }
  
}
