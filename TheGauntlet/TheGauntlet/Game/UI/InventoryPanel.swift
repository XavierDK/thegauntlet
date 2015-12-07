//
//  InventoryPanel.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 07/12/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit


protocol InventoryPanelDataSource {
  
  func numberOfItemsForPanel(panel: InventoryPanel) -> Int
}


class InventoryButton : SKNode {
  
  let width: CGFloat = 50
  let height: CGFloat = 50
  let marginWidth: CGFloat = 50
  let marginHeight: CGFloat = 50
  let imageNode: SKSpriteNode
  
  init(name: String) {
    
    self.imageNode = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.width, height: self.height))
    self.imageNode.position = CGPoint(x: UIScreen.mainScreen().bounds.width / 2 - self.width / 2 - self.marginWidth, y: -1 * UIScreen.mainScreen().bounds.height / 2 + self.height / 2 + self.marginHeight)
    self.imageNode.name = name
    
    super.init()
    
    self.addChild(self.imageNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


class InventoryItem : SKNode {
  
  let imageNode: SKSpriteNode
  
  let max : Int
  let index : Int
  
  let width : CGFloat
  let height : CGFloat
  
  var line : Int {
    
    return self.index / self.max
  }
  
  init(index: Int, max: Int, width: CGFloat, height: CGFloat) {
    
    self.max = max
    self.index = index
    self.width = width
    self.height = height
    
    self.imageNode = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.width, height: self.height))
    
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func clean() {
    
  }
}


class InventoryPanel : SKNode {
  
  let background : SKSpriteNode
  let button : InventoryButton
  var items : [InventoryItem]
  let backgroundName : String = "background"
  let inventoryButtonName : String = "inventoryButton"
  let animationDuration: NSTimeInterval = 0.3
  let fadeForBackground: CGFloat = 0.7
  var isPanelOpened: Bool = false
  
  var dataSource: InventoryPanelDataSource? {
    didSet {
      
      self.setupItems()
    }
  }
  
  var itemsNumber: Int?
  
  let nbMaxItemsPerLine: Int = 3
//  let itemHorizontalMargin: CGFloat = 50
//  let itemVerticalMargin: CGFloat = 50
  let itemWidth: CGFloat = 50
  let itemHeight: CGFloat = 50
  let itemHorizontalMargin : CGFloat = 150
  let itemVerticalMargin : CGFloat = 150
  
  var itemMarginWidth : CGFloat {
    
    let iHm = (UIScreen.mainScreen().bounds.size.width - (CGFloat(self.nbMaxItemsPerLine) * self.itemWidth) - (self.itemHorizontalMargin * 2)) / CGFloat(self.nbMaxItemsPerLine - 1)
    return iHm
  }
  
  var itemMarginHeight: CGFloat {
    
    let iVm = (UIScreen.mainScreen().bounds.size.height - (CGFloat(self.numberLines) * self.itemHeight) - (self.itemVerticalMargin * 2)) / CGFloat(self.numberLines - 1)
    return iVm
  }
  
  var numberLines : Int {
    
    if let itemsNumber = self.itemsNumber {
      let nb = Int(ceil(CGFloat(itemsNumber) / CGFloat(self.nbMaxItemsPerLine)))
      
      return nb
    }
    return 0
  }

  
  override init() {
    
    self.background = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
    self.button = InventoryButton(name: self.inventoryButtonName)
    self.items = [InventoryItem]()
    
    super.init()
    
//    self.userInteractionEnabled = true
    
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    
    self.setupBackground()
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
    
    if let dataSource = self.dataSource {
      
      self.itemsNumber = dataSource.numberOfItemsForPanel(self)
      
      print("\(self.itemMarginWidth) - \(self.itemMarginHeight)")
      
      if let nbItems = self.itemsNumber {
        
        for i in 0 ..< nbItems {
          
          let item = InventoryItem(index: i, max: self.nbMaxItemsPerLine, width: self.itemWidth, height: self.itemHeight)
          self.items.append(item)
        }
      }
    }
  }
  
  func reloadData() {
    
    for item in self.items {
      item.clean()
    }
    self.items.removeAll()
    self.setupItems()
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
  }
  
  func closePanel() {
    
    self.isPanelOpened = false
    let fadeAction: SKAction = SKAction.fadeOutWithDuration(self.animationDuration)
    self.background.runAction(fadeAction)
  }
}
