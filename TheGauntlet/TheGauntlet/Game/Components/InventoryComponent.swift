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
  
  var gauntletUsed: GauntletComponent?
  var gauntlets: [GauntletComponent]
  
  override init() {
    
    self.gauntlets = [GauntletComponent]()
    super.init()
  }
  
  
  func addGauntlet(gauntlet: GauntletComponent) {
    
    self.gauntlets.append(gauntlet)
    if self.gauntletUsed == nil {
      self.gauntletUsed = gauntlet
    }
  }
}