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
  
  func levelFromLevelObject(levelObject: LevelObject) -> GameScene {
    
    let gameScene: GameScene = GameScene(size: UIScreen.mainScreen().bounds.size)
    
    // TEST
    gameScene.backgroundColor = UIColor.whiteColor()
    //
    
    gameScene.gridManager = GridManager(levelSize: levelObject.size, entityManager: gameScene.entityManager)
    
    gameScene.interfaceManager = InterfaceManager(levelSize: levelObject.size)
    
    if GameConstant.Debug.Enable {
      self.addGridForSize(levelObject.size, gameScene: gameScene)
    }
    
    for levelComponent in levelObject.components {
      
      switch levelComponent.type! {
      case ComponentType.Start:
        self.addPlayerForComponent(levelComponent, gameScene:gameScene)
      case ComponentType.End:
        break
      case ComponentType.Wall:
        self.addWallForComponent(levelComponent, gameScene:gameScene)
      case ComponentType.Bloc:
        self.addBlockForComponent(levelComponent, gameScene:gameScene)
      case ComponentType.Gauntlet:
        self.addGauntletForComponent(levelComponent, gameScene:gameScene)
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
        let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: GameConstant.Sprites.Grid)
        spriteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spriteNode.size = CGSize(width: GameConstant.Entity.Size, height: GameConstant.Entity.Size)
        spriteNode.position.x = CGFloat(i + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
        spriteNode.position.y = CGFloat(j + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
        spriteNode.zPosition = CGFloat(2)
        gameScene.addChild(spriteNode)
      }
    }
  }
  
  func addPlayerForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Player)
    let player = Player(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(player)
    gameScene.gridManager.addEntity(player, x: component.position.x, y: component.position.y)
  }
  
  func addWallForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Wall)
    let wall = Wall(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(wall)
    gameScene.gridManager.addEntity(wall, x: component.position.x, y: component.position.y)
  }
  
  func addBlockForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Block)
    let basicBloc = Bloc(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(basicBloc)
    gameScene.gridManager.addEntity(basicBloc, x: component.position.x, y: component.position.y)
  }
  
  func addGauntletForComponent(component: LevelComponent, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Gauntlet)
    let basicGauntlet = Gauntlet(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(basicGauntlet)
    gameScene.gridManager.addEntity(basicGauntlet, x: component.position.x, y: component.position.y)
  }
  
  func spriteNodeFor(component: LevelComponent, imageNamed: String) -> SKSpriteNode {
    
    let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode.size = CGSize(width: GameConstant.Entity.Size, height: GameConstant.Entity.Size)
    spriteNode.position.x = CGFloat(component.position.x + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
    spriteNode.position.y = CGFloat(component.position.y + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
    spriteNode.zPosition = CGFloat(component.position.z)
    spriteNode.zRotation = CGFloat(component.angle.rawValue) / CGFloat(180) * CGFloat(M_PI)
    
    return spriteNode
  }
}