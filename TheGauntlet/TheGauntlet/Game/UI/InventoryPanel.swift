//
//  InventoryPanel.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 07/12/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit

class InventoryButton : SKNode {
  
  let marginWidth: CGFloat = 15 * UIScreen.mainScreen().scale
  let marginHeight: CGFloat = 15 * UIScreen.mainScreen().scale
  let imageNode: SKSpriteNode
  let width: CGFloat
  let height: CGFloat
  
  var buttonPosition : CGPoint {
    return CGPoint(x: UIScreen.mainScreen().bounds.width / 2 - self.width / 2 - self.marginWidth, y: UIScreen.mainScreen().bounds.height / 2 - self.height / 2 - self.marginHeight)
  }
  
  init(name: String, width: CGFloat, height: CGFloat) {
    
    self.width = width
    self.height = height
    self.imageNode = SKSpriteNode(color: UIColor.brownColor(), size: CGSize(width: width, height: height))
    self.imageNode.name = name
    
    super.init()
    
    self.imageNode.position = self.buttonPosition
    self.addChild(self.imageNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


class InventoryItem : SKNode {
  
  let positionIndex: [Int : CGPoint] =
  [0 : CGPoint(x: -50 * UIScreen.mainScreen().scale, y: 25 * UIScreen.mainScreen().scale),
    1 : CGPoint(x: -0  * UIScreen.mainScreen().scale, y: 25 * UIScreen.mainScreen().scale),
    2 : CGPoint(x: 50 * UIScreen.mainScreen().scale, y: 25 * UIScreen.mainScreen().scale),
    3 : CGPoint(x: -25 * UIScreen.mainScreen().scale, y: -25 * UIScreen.mainScreen().scale),
    4 : CGPoint(x: 25 * UIScreen.mainScreen().scale, y: -25 * UIScreen.mainScreen().scale)]
  
  let imageNode: SKSpriteNode
  
  let width : CGFloat
  let height : CGFloat
  let index : Int
  
  init(width: CGFloat, height: CGFloat, index: Int) {
    
    self.width = width
    self.height = height
    self.index = index
    
    self.imageNode = SKSpriteNode(color: UIColor.lightGrayColor(), size: CGSize(width: self.width, height: self.height))
    
    super.init()
    
    self.addChild(self.imageNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func movingPosition() -> CGPoint {
    
    if let position = self.positionIndex[self.index] {
      return position
    }
    return CGPointZero
  }
}


class InventoryPanel : SKNode {
  
  let background : SKSpriteNode
  let button : InventoryButton
  var items : [InventoryItem]
  let backgroundName : String = "background"
  let inventoryButtonName : String = "inventoryButton"
  let animationDuration: NSTimeInterval = 0.20
  let fadeForBackground: CGFloat = 0.9
  var isPanelOpened: Bool = false
  
  let width: CGFloat = 25 * UIScreen.mainScreen().scale
  let height: CGFloat = 25 * UIScreen.mainScreen().scale
  let numberItems: Int = 5
  
  
  override init() {
    
    self.background = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
    self.button = InventoryButton(name: self.inventoryButtonName, width: self.width, height: self.height)
    self.items = [InventoryItem]()
    
    super.init()
    
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    
    self.setupBackground()
    self.setupItems()
    self.setupButton()
  }
  
  func setupBackground() {
    
    self.background.name = self.backgroundName
    self.background.alpha = 0
    self.addChild(self.background)
  }
  
  func setupButton() {
    
    self.addChild(self.button)
  }
  
  func setupItems() {
    
    for i in 0 ..< self.numberItems {
      
      let item = InventoryItem(width: self.width, height: self.height, index: i)
      self.items.append(item)
      item.position = self.button.buttonPosition
      self.addChild(item)
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    super.touchesBegan(touches, withEvent: event)
    
    let touch: UITouch? = touches.first
    
    if let touch = touch {
      let location: CGPoint = touch.locationInNode(self)
      let node: SKNode = self.nodeAtPoint(location)
      
      if let nodeName = node.name {
        self.actionForNodeName(nodeName)
      }
    }
  }
  
  func actionForNodeName(nodeName: String) {
    
    switch nodeName {
      
    case self.inventoryButtonName:
      
      if !self.isPanelOpened {
        self.openPanel()
      }
      else {
        self.closePanel()
      }
      
    case self.backgroundName:
      
      if self.isPanelOpened {
        self.closePanel()
      }
      
    default:
      break
    }
  }
  
  func openPanel() {
    
    self.isPanelOpened = true
    let fadeAction: SKAction = SKAction.fadeAlphaTo(self.fadeForBackground, duration: self.animationDuration)
    self.background.runAction(fadeAction)
    
    for item in self.items {
      
      let moveAction = SKAction.moveTo(item.movingPosition(), duration: self.animationDuration)
      item.runAction(moveAction)
    }
  }
  
  func closePanel() {
    
    self.isPanelOpened = false
    let fadeAction: SKAction = SKAction.fadeOutWithDuration(self.animationDuration)
    self.background.runAction(fadeAction)
    
    for item in self.items {
      
      let moveAction = SKAction.moveTo(self.button.buttonPosition, duration: self.animationDuration)
      item.runAction(moveAction)
    }
  }
}
 