//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, JoystickDelegate {
  
  var lastUpdateTimeInterval: NSTimeInterval = 0
  
  var gameOver = false
  
  var entityManager: EntityManager!
  var joystick = Joystick(padImgName: "joystick_pad", baseImgName: "joystick_base")
  
  override func didMoveToView(view: SKView) {
    
    joystick.delegate = self
    addChild(joystick)
    
    entityManager = EntityManager(scene: self)
    
    let player = Player(spriteNode: self.childNodeWithName("player") as? SKSpriteNode, entityManager: entityManager)
    entityManager.add(player)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch in touches {
      let location = touch.locationInNode(self)
      
      self.joystick.startJoystickForLocation(location)
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch in touches {
      let location = touch.locationInNode(self)
      
      self.joystick.moveJoystickForLocation(location)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    self.joystick.endJoystick()
  }
  
}
