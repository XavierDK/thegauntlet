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
import UIKit

enum FileParserError: ErrorType {
  case NotFound(String)
  case BadFormat(String)
  case Empty(String)
  case MissingValue(String)
}


protocol FileParserManager {
  
  func levelObjectsFromLevelName(levelName: String) throws -> LevelObject
  func dataFromFile(levelName: String) throws -> NSDictionary
  func levelObjectFromDataDic(dataDic: NSDictionary) throws -> LevelObject
  func levelComponentForDic(component: NSDictionary) throws -> LevelComponent
  func alertErrorForError(error: FileParserError)
}


extension FileParserManager {
  
  func levelObjectsFromLevelName(levelName: String) throws -> LevelObject {
    
    let dataDic = try self.dataFromFile(levelName)
    let levelObject = try self.levelObjectFromDataDic(dataDic)
    return levelObject
  }
  
  
  func dataFromFile(levelName: String) throws -> NSDictionary  {
    
    guard let path = NSBundle.mainBundle().pathForResource(levelName, ofType: "json") else {
      throw FileParserError.NotFound("Level file not found")
    }
    guard let jsonData = NSData(contentsOfFile: path) else {
      throw FileParserError.Empty("Level file is empty")
    }
    
    do {
      let jsonData = try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
      return jsonData
    } catch {
      throw FileParserError.BadFormat("Level format incorrect")
    }
  }
  
  
  func levelObjectFromDataDic(dataDic: NSDictionary) throws -> LevelObject {
    
    guard let name = dataDic["name"] as? String else {
      throw FileParserError.MissingValue("Level name is missing")
    }
    guard let size = dataDic["size"] as? NSDictionary else {
      throw FileParserError.MissingValue("Level size is missing")
    }
    guard let width = size["width"] as? CGFloat else {
      throw FileParserError.MissingValue("Level size width is missing")
    }
    guard let height = size["height"] as? CGFloat else {
      throw FileParserError.MissingValue("Level size height is missing")
    }
    guard let dataComponents = dataDic["elements"] as? NSArray else {
      throw FileParserError.MissingValue("Level elements are missing")
    }
    
    var components: [LevelComponent] = []
    
    for component in dataComponents {
      guard let component = component as? NSDictionary else {
        throw FileParserError.BadFormat("Level components format incorrect")
      }
      components.append(try self.levelComponentForDic(component))
    }
    
    return LevelObject(name: name, size:  CGSizeMake(width, height), components: components)
  }
  
  
  func levelComponentForDic(component: NSDictionary) throws -> LevelComponent {
    
    guard let type = component["type"] as? String else {
      throw FileParserError.MissingValue("Component type is missing")
    }
    guard let size = component["position"] as? NSDictionary else {
      throw FileParserError.MissingValue("Component position is missing")
    }
    guard let x = size["x"] as? Float else {
      throw FileParserError.MissingValue("Component position x is missing")
    }
    guard let y = size["y"] as? Float else {
      throw FileParserError.MissingValue("Component position x is missing")
    }
    
    let z = size["z"] as? Float ?? 1
    
    guard let angleTmp = component["angle"] as? String else {
      throw FileParserError.MissingValue("Angle is missing")
    }
    
    guard let angle = AngleComponent(rawValue: angleTmp) else {
      throw FileParserError.BadFormat("Angle has a bad value")
    }
    
    return LevelComponent(type: type, position: SCNVector3(x: x, y: y, z: z), angle: angle)
  }
  
  
  func alertErrorForError(error: FileParserError) {
    let message: String?
    switch error {
      
    case .NotFound(let mess):
      message = mess
    case .BadFormat(let mess):
      message = mess
    case .Empty(let mess):
      message = mess
    case .MissingValue(let mess):
      message = mess
    }
    
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
    }))
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
  }
}