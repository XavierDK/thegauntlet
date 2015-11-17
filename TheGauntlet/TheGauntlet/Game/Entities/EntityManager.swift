//
//  EntityManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation

import Foundation
import SpriteKit
import GameplayKit

class EntityManager
{
  var entities = Set<GKEntity>()
  let scene: SKScene
  var toRemove = Set<GKEntity>()
  
  lazy var componentSystems: [GKComponentSystem] = {
    let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
    return [moveSystem]
  }()
  
  init(scene: SKScene)
  {
    self.scene = scene
  }
  
  func add(entity: GKEntity)
  {
    entities.insert(entity)
    
    if let spriteNode = entity.componentForClass(SpriteComponent.self)?.node
    {
      if spriteNode.parent == nil {
        scene.addChild(spriteNode)
      }
    }
    for componentSystem in componentSystems {
      componentSystem.addComponentWithEntity(entity)
    }
  }
  
  func remove(entity: GKEntity)
  {
    if let spriteNode = entity.componentForClass(SpriteComponent.self)?.node
    {
      spriteNode.removeFromParent()
    }    
    entities.remove(entity)
    toRemove.insert(entity)
  }
  
  func update(deltaTime: CFTimeInterval) {
    
    for componentSystem in componentSystems {
      componentSystem.updateWithDeltaTime(deltaTime)
    }
    
    for curRemove in toRemove {
      for componentSystem in componentSystems {
        componentSystem.removeComponentWithEntity(curRemove)
      }
    }
    toRemove.removeAll()
  }
  
  func player() -> Player? {
    for entity in self.entities {
      
      if entity is Player {        
        return entity as? Player
      }
    }
    return nil
  }
}