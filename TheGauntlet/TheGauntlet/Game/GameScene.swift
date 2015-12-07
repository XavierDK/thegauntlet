//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
  
  var entityManager: EntityManager!
  var actionsManager: ActionsManager = ActionsManager()
  var gridManager: GridManager!
  var cameraManager: CameraManager!
  
  let inventoryPanel: InventoryPanel
  
  var cameraActivated: Bool = false
  var zoomActivated: Bool = false
  
  override init(size: CGSize) {
    
    self.inventoryPanel = InventoryPanel()
    
    super.init(size: size)
    
    self.anchorPoint = CGPointMake(0, 0)
    self.entityManager = EntityManager(scene: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    
    self.scene?.scaleMode = .AspectFit
    self.camera = self.cameraManager.camera
    self.addChild(self.cameraManager.camera)
    
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchAction:")
    pinchGesture.delegate = self
    self.view?.addGestureRecognizer(pinchGesture)
    
    var swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    swipeGesture.direction = .Up
    swipeGesture.delegate = self
    self.view?.addGestureRecognizer(swipeGesture)
    
    swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    swipeGesture.direction = .Down
    swipeGesture.delegate = self
    self.view?.addGestureRecognizer(swipeGesture)
    
    swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    swipeGesture.direction = .Left
    swipeGesture.delegate = self
    self.view?.addGestureRecognizer(swipeGesture)
    
    swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
    swipeGesture.direction = .Right
    swipeGesture.delegate = self
    self.view?.addGestureRecognizer(swipeGesture)
    
    self.inventoryPanel.zPosition = 999
    self.cameraManager.camera.addChild(self.inventoryPanel)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    self.inventoryPanel.touchesBegan(touches, withEvent: event)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    self.inventoryPanel.touchesMoved(touches, withEvent: event)
    
    if touches.count > 2 {
      
      self.cameraActivated = false
      self.cameraManager.resetCamera()
    }
    
    if touches.count == 2 {
      
      self.cameraActivated = true
      self.cameraManager.moveCameraForTouches(touches)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    self.inventoryPanel.touchesEnded(touches, withEvent: event)
    
    self.cameraManager.resetCamera()
    self.cameraActivated = false
  }
  
  override func update(currentTime: NSTimeInterval) {
    
    self.entityManager.update(currentTime)
    
    if !self.cameraActivated {
      let player = self.entityManager.player()
      if let spriteComponent = player?.componentForClass(SpriteComponent.self) {
        
        if self.zoomActivated {
          self.cameraManager.updatePositionForPosition(spriteComponent.node.position, andIsAction: true, andDuration: 0.1)
        }
        else {
          self.cameraManager.updatePositionForPosition(spriteComponent.node.position)
        }
      }
    }
  }
  
  override func didChangeSize(oldSize: CGSize) {
    
    super.didChangeSize(oldSize)
  }
  
  
  //
  // MARK: Actions
  //
  
  func pinchAction(sender: UIPinchGestureRecognizer) {
    
    self.zoomActivated = true
    
    self.cameraManager.updateZoomForScale(sender.scale)
    
    if sender.state == .Ended {
      self.cameraManager.endUpdateZoom()
      self.zoomActivated = false
    }
  }
  
  func swipeAction(sender: UISwipeGestureRecognizer) {
    
    self.actionsManager.addActionForDirection(sender.direction)
  }

  
  //
  // MARK: Gestures Delegate
  //
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    
    if cameraActivated {
      return false
    }
    return true
  }
}
