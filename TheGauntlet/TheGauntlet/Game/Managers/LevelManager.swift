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
  
  let entitySize: CGFloat = 20.0
  
  let marginCase: Int = 2
  
  let playerSpriteName: String = "character"
  let wallSpriteName: String = "wall"
  let basicBlocSpriteName: String = "basic_bloc"
  let squareGridSpriteName: String = "square"
  
  
  func levelFromLevelObject(levelObject: LevelObject) -> GameScene {
    
    let gameScene: GameScene = GameScene(size: CGSize(width: CGFloat(levelObject.size.width + marginCase * 2) * entitySize, height: CGFloat(levelObject.size.height + marginCase * 2) * entitySize))
    
    // TEST
    gameScene.backgroundColor = UIColor.greenColor()
    //
    
    gameScene.gridManager = GridManager(levelSize: levelObject.size)
    
    self.addGridForSize(levelObject.size, gameScene: gameScene)
    
    for levelComponent in levelObject.components {
      
      switch levelComponent.type! {
      case ComponentType.Start:
        self.addPlayerForComponent(levelComponent, gameScene:gameScene)
      case ComponentType.End:
        break
      case ComponentType.Wall:
        self.addWallForComponent(levelComponent, gameScene:gameScene)
      case ComponentType.BasicBloc:
        self.addBasicBlocForComponent(levelComponent, gameScene:gameScene)
      }
    }
    
    return gameScene
  }
  
  //
  // DEBUG CONSUM A LOT OF NODE
  //
  func addGridForSize(size: LevelSize, gameScene: GameScene) {
    
    for j in 0 ..< size.height {
      for i in 0 ..< size.width {
        let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: squareGridSpriteName)
        spriteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spriteNode.size = CGSize(width: entitySize, height: entitySize)
        spriteNode.position.x = CGFloat(i + marginCase) * entitySize + entitySize / 2
        spriteNode.position.y = CGFloat(j + marginCase) * entitySize + entitySize / 2
        spriteNode.zPosition = CGFloat(2)
        gameScene.addChild(spriteNode)
      }
    }
  }
  
  
  func addPlayerForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: playerSpriteName)
    let player = Player(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(player)
    gameScene.gridManager.addEntity(player, x: component.position.x, y: component.position.y)
  }
  
  
  func addWallForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: wallSpriteName)
    let wall = Wall(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(wall)
    gameScene.gridManager.addEntity(wall, x: component.position.x, y: component.position.y)
  }
  
  
  func addBasicBlocForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: basicBlocSpriteName)
    let basicBloc = BasicBloc(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(basicBloc)
    gameScene.gridManager.addEntity(basicBloc, x: component.position.x, y: component.position.y)
  }
  
  
  func spriteNodeFor(component: LevelComponent, imageNamed: String) -> SKSpriteNode {
    
    let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode.size = CGSize(width: entitySize, height: entitySize)
    spriteNode.position.x = CGFloat(component.position.x + marginCase) * entitySize + entitySize / 2
    spriteNode.position.y = CGFloat(component.position.y + marginCase) * entitySize + entitySize / 2
    spriteNode.zPosition = CGFloat(component.position.z)
    spriteNode.zRotation = CGFloat(component.angle.rawValue) / CGFloat(180) * CGFloat(M_PI)
    
    return spriteNode
  }
}