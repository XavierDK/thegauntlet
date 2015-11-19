//
//  FileManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit


// PUT IN THROW
class FileParserManager {
  
  func levelObjectsFromLevelName(levelName: String) -> LevelObject? {
    
    let dataDic = self.dataFromFile(levelName)
    
    var levelObject: LevelObject?
    if let dataDic = dataDic {
      levelObject = self.levelObjectFromDataDic(dataDic)
    }
    
    return levelObject
  }
  
  func dataFromFile(levelName: String) -> NSDictionary? {
    
    if let path = NSBundle.mainBundle().pathForResource(levelName, ofType: "json") {
      if let jsonData = NSData(contentsOfFile: path)
      {
        do {
          let jsonData = try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
          return jsonData
        } catch {
          return nil
        }
      }
    }
    return nil;
  }
  
  func levelObjectFromDataDic(dataDic: NSDictionary) -> LevelObject {
    
    guard let name = dataDic["name"] as? String else {
      fatalError("Name level is mandatory")
    }
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    if let size = dataDic["size"] as? NSDictionary {
      if let widthTmp = size["width"] as? CGFloat,
        let heightTmp = size["height"] as? CGFloat {
          width = widthTmp
          height = heightTmp
      }
    }
    
    var components: [LevelComponent] = []
    
    if let dataComponents = dataDic["elements"] as? NSArray {
      for component in dataComponents {
        if let component = component as? NSDictionary {
          components.append(self.levelComponentForDic(component))
        }
      }
    }
    
    return LevelObject(name: name, size:  CGSizeMake(width, height), components: components)
  }
  
  func levelComponentForDic(component: NSDictionary?) -> LevelComponent {
    
    guard let component = component else {
      fatalError("Bad syntax component")
    }
    
    guard let name = component["type"] as? String else {
      fatalError("Type component is mandatory")
    }
    
    
    //PUT IN GUARD
    var x: Float = 0
    var y: Float = 0
    var z: Float = 1
    if let size = component["position"] as? NSDictionary {
      if let xTmp = size["x"] as? Float,
        let yTmp = size["y"] as? Float,
        let zTmp = size["z"] as? Float{
          x = xTmp
          y = yTmp
          z = zTmp
      }
    }
    
    guard let angleTmp = component["angle"] as? String else {
      fatalError("Angle component is mandatory")
    }
    
    guard let angle = AngleComponent(rawValue: angleTmp) else {
      fatalError("Angle component is not a good value")
    }
    
    return LevelComponent(name: name, position: SCNVector3(x: x, y: y, z: z), angle: angle)
  }
}