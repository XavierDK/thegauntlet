//
//  LevelManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 19/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit

class LevelManager {
  
  let fileManager: FileParserManager = FileParserManager()
  
  func levelFromLevelObject(levelObject: LevelObject) -> SKScene {
    
    guard let levelObject: LevelObject = levelObject else {
    
      fatalError("")
    }
    return SKScene()
  }
}