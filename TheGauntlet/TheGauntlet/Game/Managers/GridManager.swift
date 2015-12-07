//
//  GridManagers.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 22/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import GameKit

class GridManager {
  
  var grid: Array<Array<Set<GKEntity>>>
  let levelSize: LevelSizeModel
  let entityManager: EntityManager
  
  init(levelSize: LevelSizeModel, entityManager: EntityManager) {
    self.grid = Array<Array<Set<GKEntity>>>()
    self.levelSize = levelSize
    self.entityManager = entityManager
    
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
  
  
  func moveEntity(entity: GKEntity, direction: Orientation) -> Bool {
    
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
    
    if let gauntletUsed = entity.componentForClass(InventoryComponent.self)?.itemUsed {
      
      let res = gauntletUsed.actionForGrid(self, newX: newX, newY: newY, direction: direction)
      newX = res.0
      newY = res.1
    }
    
    if !self.checkLevelLimit(newX, newY: newY) {
      return false
    }
    
    if self.checkComponentClass(ColliderComponent.self, newX: newX, newY: newY).0 {
      return false
    }
    
    let res = self.checkComponentClass(GetComponent.self, newX: newX, newY: newY)
    
    if res.0, let object = res.1 {
      if let inventory = entity.componentForClass(InventoryComponent.self),
        let objectToGet = object.componentForClass(GetComponent.self) {
          if let gauntlet = objectToGet.objectToGet as? GloveItem {
            inventory.addGauntlet(gauntlet)
          }
      }
      self.entityManager.remove(object)
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
  
  
  func checkComponentClass(componentType: GKComponent.Type, newX: Int, newY: Int) -> (Bool, GKEntity?) {
    
    for entity in self.grid[newY][newX] {
      if entity.componentForClass(componentType) != nil {
        return (true, entity)
      }
    }
    
    return (false, nil)
  }
}