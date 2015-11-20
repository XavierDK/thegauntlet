//
//  LevelManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 19/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit

enum LevelEntity {
  
  
}

class LevelManager {
  
  let entitySize: CGFloat = 20.0
  
  func levelFromLevelObject(levelObject: LevelObject) -> GameScene {
    
//    let gameScene: GameScene = GameScene(size: CGSize(width: CGFloat(levelObject.size.width) * entitySize, height: CGFloat(levelObject.size.height) * entitySize))
    return GameScene(size: CGSizeZero)
  }
}