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
            // oh boy
            let basetype = BaseType(rawValue: anElement.basetype)!
            switch basetype {
            case BaseType.User:
                let specifictype = SpecificTypeUser(rawValue: anElement.specifictype)!
                switch specifictype {
                case SpecificTypeUser.In:
                    self.addPlayerForComponent(anElement, gameScene:gameScene)
                    break
                case SpecificTypeUser.Out:
                    //                        self.addLevelExitForComponent(levelComponent, gameScene:gameScene)
                    break
                }
                break
            case BaseType.Case:
                let specifictype = SpecificTypeCase(rawValue: anElement.specifictype)!
                switch specifictype {
                case SpecificTypeCase.Simple, SpecificTypeCase.Muddy, SpecificTypeCase.Ephemeral, SpecificTypeCase.Actionable:
                    //                        self.addLevelExitForComponent(levelComponent, gameScene:gameScene)
                    break
                case SpecificTypeCase.Hole:
                    //                        self.addLevelExitForComponent(levelComponent, gameScene:gameScene)
                    break
                }
                break;
            case BaseType.Block:
                let specifictype = SpecificTypeBlock(rawValue: anElement.specifictype)!
                switch specifictype {
                case SpecificTypeBlock.Boulder, SpecificTypeBlock.BoulderCracked, SpecificTypeBlock.Tree, SpecificTypeBlock.BurningTree:
                    self.addBlockForComponent(anElement, gameScene:gameScene)
                    break
                case SpecificTypeBlock.Wall:
                    self.addWallForComponent(anElement, gameScene:gameScene)
                    break
                }
                break;
            case BaseType.Item:
                let specifictype = SpecificTypeItem(rawValue: anElement.specifictype)!
                switch specifictype {
                case SpecificTypeItem.Rope, SpecificTypeBlock.Hammer, SpecificTypeBlock.Axe, SpecificTypeBlock.WaterSeal:
                    //                        output.appendContentsOf("H")
                    break
                case SpecificTypeBlock.Glove:
                    self.addGauntletForComponent(anElement, gameScene:gameScene)
                    break
                }
                break;
            }
        }
        
        return gameScene
    }
    

//
//  func levelFromLevelObject(levelObject: LevelObject) -> GameScene {
//
//    let gameScene: GameScene = GameScene(size: UIScreen.mainScreen().bounds.size)
//    
//    // TEST
//    gameScene.backgroundColor = UIColor.whiteColor()
//    //
//    
//    gameScene.gridManager = GridManager(levelSize: levelObject.size, entityManager: gameScene.entityManager)
//    
//    gameScene.interfaceManager = InterfaceManager(levelSize: levelObject.size)
//    
//    if GameConstant.Debug.Enable {
//      self.addGridForSize(levelObject.size, gameScene: gameScene)
//    }
//    
//    for levelComponent in levelObject.components {
//      
//      switch levelComponent.type! {
//      case ComponentType.Start:
//        self.addPlayerForComponent(levelComponent, gameScene:gameScene)
//      case ComponentType.End:
//        break
//      case ComponentType.Wall:
//        self.addWallForComponent(levelComponent, gameScene:gameScene)
//      case ComponentType.Bloc:
//        self.addBlockForComponent(levelComponent, gameScene:gameScene)
//      case ComponentType.Gauntlet:
//        self.addGauntletForComponent(levelComponent, gameScene:gameScene)
//      }
//    }
//    
//    return gameScene
//  }
//  
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
  
  func addPlayerForComponent(component: ElementModel, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Player)
    let player = Player(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(player)
    gameScene.gridManager.addEntity(player, x: component.position.x, y: component.position.y)
  }
  
  func addWallForComponent(component: ElementModel, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Wall)
    let wall = Wall(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(wall)
    gameScene.gridManager.addEntity(wall, x: component.position.x, y: component.position.y)
  }
  
  func addBlockForComponent(component: ElementModel, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Block)
    let basicBloc = Bloc(component: component, spriteNode: spriteNode, actionsManager: gameScene.actionsManager, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(basicBloc)
    gameScene.gridManager.addEntity(basicBloc, x: component.position.x, y: component.position.y)
  }
  
  func addGauntletForComponent(component: ElementModel, gameScene: GameScene) {
    
    let spriteNode = self.spriteNodeFor(component, imageNamed: GameConstant.Sprites.Gauntlet)
    let basicGauntlet = Gauntlet(component: component, spriteNode: spriteNode, gridManager: gameScene.gridManager)
    gameScene.entityManager.add(basicGauntlet)
    gameScene.gridManager.addEntity(basicGauntlet, x: component.position.x, y: component.position.y)
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