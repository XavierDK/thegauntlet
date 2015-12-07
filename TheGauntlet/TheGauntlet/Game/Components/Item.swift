//
//  GauntletComponent.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 24/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import GameplayKit
import SpriteKit

protocol Item {
  
  func actionForGrid(gridManager: GridManager, newX: Int, newY: Int, direction: Orientation) -> (Int, Int)
}
