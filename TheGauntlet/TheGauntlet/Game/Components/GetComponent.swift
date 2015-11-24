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
  
  let objectToGet: GKComponent
  
  init(objectToGet: GKComponent) {
    self.objectToGet = objectToGet
    super.init()
  }
}
