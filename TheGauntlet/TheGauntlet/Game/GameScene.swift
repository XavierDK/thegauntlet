//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit

enum TouchType {
  case Action
  case Camera
  case Inventory
}

class GameScene: SKScene {
  
  var entityManager: EntityManager!
  var actionsManager: ActionsManager = ActionsManager()
  var gridManager: GridManager!
  var interfaceManager: InterfaceManager!
  
  var touchType: TouchType?
  
  
  override init(size: CGSize) {
    
    super.init(size: size)
    
    self.anchorPoint = CGPointMake(0, 0)
    self.entityManager = EntityManager(scene: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    
    self.scene?.scaleMode = .AspectFit
    self.camera = self.interfaceManager.sceneCamera
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    if self.touchType != nil {
      
      self.actionsManager.resetTouch()
      self.touchType = nil
    }
    
    if touches.count == 1 {
      
      self.touchType = .Action
      let touch = touches.first
      
      if let touch = touch {
        let location = touch.locationInNode(self)
        self.actionsManager.touchBeganForLocation(location)
      }
    }
    
    else {
      print("OK")
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    if touches.count > 1 {
      
      self.touchType = .Camera
      self.actionsManager.resetTouch()      
    }
    
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

    if touches.count == 1 {
      if self.touchType == .Action {
        let touch = touches.first
        
        if let touch = touch {
          let location = touch.locationInNode(self)
          self.actionsManager.touchEndedForLocation(location)
        }
      }
    }
    
    self.touchType = nil
  }
  
  override func update(currentTime: NSTimeInterval) {
    self.entityManager.update(currentTime)
    
    let player = self.entityManager.player()
    if let spriteComponent = player?.componentForClass(SpriteComponent.self) {
      self.interfaceManager.updatePositionForNode(spriteComponent.node)
    }
  }
  
  override func didChangeSize(oldSize: CGSize) {
    
    super.didChangeSize(oldSize)
  }
}
