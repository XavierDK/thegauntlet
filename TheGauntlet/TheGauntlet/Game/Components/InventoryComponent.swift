//
//  InventoryComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 24/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class InventoryComponent: GKComponent {
  
  var itemUsed: Item?
  var items: [Item]
  
  override init() {
    
    self.items = [Item]()
    super.init()
  }  
  
  func addGauntlet(gauntlet: Item) {
    
    self.items.append(gauntlet)
    if self.itemUsed == nil {
      self.itemUsed = gauntlet
    }
  }
}