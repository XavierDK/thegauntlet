//
//  LevelEnum.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation

enum Level: String {
  
  case Level00 = "Level00"
  
  static func levelForIndex(index: Int) -> Level {
    
    switch index {
    case 0:
      return Level00
    default:
      return Level00
    }
  }
}
