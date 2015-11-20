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
  var actionsManager: ActionsManager = ActionsManager()
  
  override init(size: CGSize) {
    
    super.init(size: size)
    self.entityManager = EntityManager(scene: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    
    let player = Player(spriteNode: self.childNodeWithName("player") as? SKSpriteNode, entityManager: entityManager, actionsManager: self.actionsManager)
    entityManager.add(player)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    let touch = touches.first
    
    if let touch = touch {
      let location = touch.locationInNode(self)
      self.actionsManager.touchBeganForLocation(location)
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    let touch = touches.first
    
    if let touch = touch {
      let location = touch.locationInNode(self)
      self.actionsManager.touchEndedForLocation(location)
    }
  }
  
  override func update(currentTime: NSTimeInterval) {
    self.entityManager.update(currentTime)
  }
  
}
