//
//  GameScene.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {    
  
  var entityManager: EntityManager!
  var actionsManager: ActionsManager = ActionsManager()
  var gridManager: GridManager!
  var interfaceManager: InterfaceManager!
  
  override init(size: CGSize) {

    super.init(size: size)
  
    self.anchorPoint = CGPointMake(0, 0)
    self.entityManager = EntityManager(scene: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
   
//    self.addChild(self.sceneCamera)
//    self.sceneCamera.xScale = 0.1
//    self.sceneCamera.yScale = 0.1
    self.scene?.scaleMode = .AspectFit
    self.camera = self.interfaceManager.sceneCamera

//    let lbl: SKLabelNode = SKLabelNode(fontNamed: "Arial")
//    lbl.text = "Drag this label"
//    lbl.fontSize = 5
//    lbl.fontColor = UIColor.blackColor()
//    lbl.position = CGPointMake(0, 0)
//    lbl.zPosition = 99
//    self.sceneCamera.addChild(lbl)    
//    
//    let backgroundCrop = SKCropNode()
//    let node = SKNode()
//    
//    let spr1 = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 40, height: 40))
//    spr1.position = CGPoint(x: 100, y: 100)
//    node.addChild(spr1)
//    
//    let spr2 = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 40, height: 40))
//    spr2.position = CGPoint(x: 150, y: 100)
//    node.addChild(spr2)
//    
//    backgroundCrop.maskNode = node
//    
//    let backgroundImage = SKSpriteNode(imageNamed: "basic_bloc")
//    backgroundImage.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
//    backgroundImage.position = CGPoint(x: CGRectGetMinY(self.frame), y: CGRectGetMinX(self.frame))
//    
//    backgroundCrop.zPosition = 99
//    backgroundCrop.addChild(backgroundImage)
//    
//    self.addChild(backgroundCrop)
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
      self.interfaceManager.sceneCamera.position = CGPoint(x:spriteComponent.node.position.x,
        y: spriteComponent.node.position.y )
    }
  }
  
  override func didChangeSize(oldSize: CGSize) {
    
    super.didChangeSize(oldSize)
  }
  
}
