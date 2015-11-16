//
//  Joystick.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 15/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit


protocol JoystickDelegate {
  
}


class Joystick: SKNode {
  
  let padNode: SKSpriteNode
  let baseNode: SKSpriteNode
  var delegate: JoystickDelegate?
  
  var stickActive: Bool = false
  
  init(padImgName: String, baseImgName: String) {
    
    let padText: SKTexture = SKTexture(imageNamed: padImgName)
    let baseText: SKTexture = SKTexture(imageNamed: baseImgName)
    self.padNode = SKSpriteNode(texture: padText, color: SKColor.whiteColor(), size: padText.size())
    self.baseNode = SKSpriteNode(texture: baseText, color: SKColor.whiteColor(), size: baseText.size())
    self.padNode.alpha = 0.4
    self.baseNode.alpha = 0.4
    
    super.init()
    
    self.addChild(self.baseNode)
    self.addChild(self.padNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startJoystickForLocation(location: CGPoint) {
    
    if CGRectContainsPoint(baseNode.frame, location) {
      stickActive = true
    }
    else {
      stickActive = false
    }
  }
  
  func moveJoystickForLocation(location: CGPoint) {
    
    if stickActive {
      let v = CGVector(dx: location.x - baseNode.position.x, dy: location.y - baseNode.position.y)
      let angle = atan2(v.dy, v.dx)
      let deg = angle * CGFloat(180 / M_PI)
      print(deg)
      
      let length: CGFloat = baseNode.size.height / 2
      let xDist: CGFloat = sin(angle - CGFloat(M_PI / 2)) * length
      let yDist: CGFloat = cos(angle - CGFloat(M_PI / 2)) * length
      
      if CGRectContainsPoint(baseNode.frame, location) &&
          abs(baseNode.position.x - xDist) > abs(location.x) &&
          abs(baseNode.position.y + yDist) > abs(location.y){
        padNode.position = location
      }
      else {
        padNode.position = CGPointMake(baseNode.position.x - xDist, baseNode.position.y + yDist)
      }
    }
  }
  
  func endJoystick() {
    
    if stickActive {
      
      let restartMiddleAction = SKAction.moveTo(baseNode.position, duration: 0.2)
      restartMiddleAction.timingMode = .EaseOut
      padNode.runAction(restartMiddleAction)
      
      stickActive = false
    }
  }
  
}