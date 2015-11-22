//
//  GridManagers.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 22/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import GameKit

enum GridDirection {
  case Up
  case Right
  case Down
  case Left
}

class GridManager {
  
  var grid: Array<Array<Set<GKEntity>>>
  var levelSize: LevelSize
  
  init(levelSize: LevelSize) {
    self.grid = Array<Array<Set<GKEntity>>>()
    self.levelSize = levelSize
    
    for _ in 0 ..< levelSize.height {
      self.grid.append(Array<Set<GKEntity>>(count: levelSize.width, repeatedValue: Set<GKEntity>()))
    }
  }
  
  
  func addEntity(entity: GKEntity, x: Int, y: Int) -> Bool {
    
    if let gridComponent = entity.componentForClass(GridComponent) {
      if !gridComponent.isOnGrid {
        gridComponent.isOnGrid = true
        self.grid[y][x].insert(entity)
        gridComponent.x = x
        gridComponent.y = y
        return true
      }
    }
    return false
  }
  
  
  func removeEntity(entity: GKEntity) {
    
    guard let gridComponent = entity.componentForClass(GridComponent.self) else {
      return
    }
    
    if gridComponent.isOnGrid {
      self.grid[gridComponent.y][gridComponent.x].remove(entity)
      gridComponent.isOnGrid = false
    }
  }
  
  
  func moveEntity(entity: GKEntity, direction: GridDirection) -> Bool {
    
    guard let gridComponent = entity.componentForClass(GridComponent.self) else {
      return false
    }
    
    var newX = gridComponent.x
    var newY = gridComponent.y
    
    switch direction {
    case .Up:
      newY++
    case .Right:
      newX++
    case .Down:
      newY--
    case .Left:
      newX--
    }
    
    if !self.checkLevelLimit(newX, newY: newY) {
      return false
    }
    
    if !self.checkCollider(newX, newY: newY) {
      return false
    }
    
    self.updateEntity(entity, newX: newX, newY: newY)
    
    return true
  }
  
  
  func updateEntity(entity: GKEntity, newX: Int, newY: Int) {
    
    self.removeEntity(entity)
    self.addEntity(entity, x: newX, y: newY)
  }
  
  
  func checkLevelLimit(newX: Int, newY: Int) -> Bool {
    
    if newX < 0 || newX >= levelSize.width ||
      newY < 0 || newY >= levelSize.height {
        return false
    }
    return true
  }
  
  
  func checkCollider(newX: Int, newY: Int) -> Bool {
    
    for entity in self.grid[newY][newX] {
      if entity.componentForClass(ColliderComponent.self) != nil {
        return false
      }
    }
    
    return true
  }
}