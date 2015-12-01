//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit
import UIKit

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
  
  var pinchGesture: UIPinchGestureRecognizer!
  var panGesture: UIPanGestureRecognizer!
  var swipeGesture: UISwipeGestureRecognizer!
  
  
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
    self.camera = self.interfaceManager.camera
    self.addChild(self.interfaceManager.camera)
    
    self.pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchAction:")
    self.view?.addGestureRecognizer(self.pinchGesture)
    
    self.panGesture = UIPanGestureRecognizer(target: self, action: "panAction:")
    self.panGesture.minimumNumberOfTouches = 2
    self.panGesture.maximumNumberOfTouches = 2
    self.view?.addGestureRecognizer(self.panGesture)
    
    self.swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    self.swipeGesture.direction = .Up
    self.view?.addGestureRecognizer(self.swipeGesture)
    
    self.swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    self.swipeGesture.direction = .Down
    self.view?.addGestureRecognizer(self.swipeGesture)
    
    self.swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    self.swipeGesture.direction = .Left
    self.view?.addGestureRecognizer(self.swipeGesture)
    
    self.swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    self.swipeGesture.direction = .Right
    self.view?.addGestureRecognizer(self.swipeGesture)
  }
  
  func pinchAction(sender: UIPinchGestureRecognizer) {
    
    print("PINCH!")
  }
  
  func panAction(sender: UIPanGestureRecognizer) {
    
//    print("PAN!")
  }
  
  func swipeAction(sender: UISwipeGestureRecognizer) {

    self.actionsManager.addActionForDirection(sender.direction)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
//    if self.touchType != nil {
//    
//      self.actionsManager.resetTouch()
//      self.touchType = nil
//    }
//    
//    if touches.count == 1 {
//      
//      self.touchType = .Action
//      let touch = touches.first
//      
//      if let touch = touch {
//        let location = touch.locationInNode(self)
//        self.actionsManager.touchBeganForLocation(location)
//      }
//    }
//    
//    if touches.count > 2 {
//      self.interfaceManager.resetCamera()
//      self.actionsManager.resetTouch()
//      self.touchType = nil
//    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
//    if touches.count > 2 {
//      
//      self.interfaceManager.resetCamera()
//      self.actionsManager.resetTouch()
//      self.touchType = nil
//    }
//    
//    if touches.count == 2 {
//
//      self.touchType = .Camera
//      self.interfaceManager.moveCameraForTouches(touches)
//    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
//    if touches.count == 1 {
//      
//      if self.touchType == .Action {
//        let touch = touches.first
//        
//        if let touch = touch {
//          let location = touch.locationInNode(self)
//          self.actionsManager.touchEndedForLocation(location)
//        }
//      }
//    }
//    
//    self.actionsManager.resetTouch()
//    
//    self.interfaceManager.resetCamera()
//    self.touchType = nil
  }
  
  override func update(currentTime: NSTimeInterval) {
    
    self.entityManager.update(currentTime)
    
    if self.touchType != .Camera {
      let player = self.entityManager.player()
      if let spriteComponent = player?.componentForClass(SpriteComponent.self) {
        self.interfaceManager.updatePositionForPosition(spriteComponent.node.position)
      }
    }
  }
  
  override func didChangeSize(oldSize: CGSize) {
    
    super.didChangeSize(oldSize)
  }
}
