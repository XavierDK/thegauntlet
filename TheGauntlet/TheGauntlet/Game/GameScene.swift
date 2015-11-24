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
  var gridManager: GridManager!
  let sceneCamera = SKCameraNode()
  
  override init(size: CGSize) {
    
    super.init(size: size)
  
    self.anchorPoint = CGPointMake(0, 0)
    self.entityManager = EntityManager(scene: self)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {

    self.addChild(self.sceneCamera)
    self.sceneCamera.xScale = 1
    self.sceneCamera.yScale = 1
    self.scene?.scaleMode = .AspectFit
    self.camera = self.sceneCamera

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
    
    let player = self.entityManager.player()
    if let spriteComponent = player?.componentForClass(SpriteComponent.self) {
      self.sceneCamera.position = CGPoint(x:spriteComponent.node.position.x - spriteComponent.node.size.width + spriteComponent.node.size.width ,
        y: spriteComponent.node.position.y + spriteComponent.node.size.height)
    }
  }
  
  override func didChangeSize(oldSize: CGSize) {
    
    super.didChangeSize(oldSize)
  }
  
}
