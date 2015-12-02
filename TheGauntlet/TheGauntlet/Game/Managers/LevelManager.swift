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
  
  func levelFromLevelObject(levelObject: LevelModel) -> GameScene {
    
    let gameScene: GameScene = GameScene(size: UIScreen.mainScreen().bounds.size)
    
    // TEST
    gameScene.backgroundColor = UIColor.whiteColor()
    //
    
    gameScene.gridManager = GridManager(levelSize: levelObject.size, entityManager: gameScene.entityManager)
    
    gameScene.interfaceManager = InterfaceManager(levelSize: levelObject.size)
    
    if GameConstant.Debug.Enable {
      self.addGridForSize(levelObject.size, gameScene: gameScene)
    }
    
    for anElement in levelObject.elements {
      let basetype = BaseType(rawValue: anElement.basetype)!
      let specifictype = SpecificTypeUser(rawValue: anElement.specifictype)!
      if basetype == BaseType.User && specifictype == SpecificTypeUser.In {
        self.addPlayerForComponent(anElement, gameScene: gameScene)
      }
      self.addElementInGameScene(anElement, gameScene:gameScene)
    }
    
    return gameScene
  }
  
  
  func spriteNameForElement(anElement: ElementModel) -> String {
    let indexes : Array<String> = [
      "Boulder", // 0
      "Cracked",
      "Tree",
      "TreeFire",
      "Wall",
      "Action", // 5
      "Ephemeral",
      "Hole",
      "Muddy",
      "Simple",
      "lvl1", // 10
      "lvl2",
      "lvl3",
      "Axe",
      "Glove",
      "Hammer", // 15
      "Rope",
      "WaterSeal",
      "UserIn",
      "UserOut"
    ]
    
    let basetype = BaseType(rawValue: anElement.basetype)!
    switch basetype {
    case BaseType.User:
      let specifictype = SpecificTypeUser(rawValue: anElement.specifictype)!
      switch specifictype {
      case SpecificTypeUser.In:
        return indexes[18]
      case SpecificTypeUser.Out:
        return indexes[19]
      }
    case BaseType.Case:
      let specifictype = SpecificTypeCase(rawValue: anElement.specifictype)!
      switch specifictype {
      case SpecificTypeCase.Simple:
        return indexes[9]
      case SpecificTypeCase.Muddy:
        return indexes[8]
      case SpecificTypeCase.Ephemeral:
        return indexes[6]
      case SpecificTypeCase.Actionable:
        return indexes[5]
      case SpecificTypeCase.Hole:
        return indexes[7]
      }
    case BaseType.Block:
      let specifictype = SpecificTypeBlock(rawValue: anElement.specifictype)!
      switch specifictype {
      case SpecificTypeBlock.Boulder:
        return indexes[0]
      case SpecificTypeBlock.BoulderCracked:
        return indexes[1]
      case SpecificTypeBlock.Tree:
        return indexes[2]
      case SpecificTypeBlock.BurningTree:
        return indexes[3]
      case SpecificTypeBlock.Wall:
        return indexes[4]
      }
    case BaseType.Item:
      let specifictype = SpecificTypeItem(rawValue: anElement.specifictype)!
      switch specifictype {
      case SpecificTypeItem.Rope:
        return indexes[16]
      case SpecificTypeBlock.Hammer:
        return indexes[15]
      case SpecificTypeBlock.Axe:
        return indexes[13]
      case SpecificTypeBlock.WaterSeal:
        return indexes[17]
      case SpecificTypeBlock.Glove:
        return indexes[14]
      }
    }
  }
  
  
  func addElementInGameScene(element: ElementModel, gameScene: GameScene) {
    let spriteNode = self.spriteNodeFor(element, imageNamed:self.spriteNameForElement(element))
    let player = Player(component: element, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(player)
    gameScene.gridManager.addEntity(player, x: element.position.x, y: element.position.y)
  }
  
  func addPlayerForComponent(component: ElementModel, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Player)
    let player = Player(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(player)
    gameScene.gridManager.addEntity(player, x: component.position.x, y: component.position.y)
  }

  
  //
  // DEBUG CONSUM A LOT OF NODE
  //
  func addGridForSize(size: LevelSizeModel, gameScene: GameScene) {
    
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
  
  func spriteNodeFor(component: ElementModel, imageNamed: String) -> SKSpriteNode {
    
    let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode.size = CGSize(width: GameConstant.Entity.Size, height: GameConstant.Entity.Size)
    spriteNode.position.x = CGFloat(component.position.x + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
    spriteNode.position.y = CGFloat(component.position.y + GameConstant.Level.Margin) * GameConstant.Entity.Size + GameConstant.Entity.Size / 2
    spriteNode.zPosition = CGFloat(component.position.z)
    spriteNode.zRotation = CGFloat(component.position.orientation.rawValue) / CGFloat(180) * CGFloat(M_PI)
    
    return spriteNode
  }
}