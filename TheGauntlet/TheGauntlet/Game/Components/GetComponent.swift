//
//  GetComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 24/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

class GetComponent: GKComponent {
  
  let objectToGet: Item
  
  init(objectToGet: Item) {
    self.objectToGet = objectToGet
    super.init()
  }
}
