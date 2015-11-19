//
//  LevelComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit

enum AngleComponent: String {
  case TOP = "__TOP__"
  case RIGHT = "__RIGHT__"
  case BOTTOM = "__BOTTOM__"
  case LEFT = "__LEFT__"
}

struct LevelComponent {
  
  let type: String
  let position: SCNVector3
  let angle: AngleComponent
}