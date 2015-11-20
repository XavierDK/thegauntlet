//
//  FileManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

enum FileParserError: ErrorType {
  case NotFound(String)
  case BadFormat(String)
  case Empty(String)
  case MissingValue(String)
}

protocol FileParserManager {
  
  func levelObjectFromLevelName(levelName: String) throws ->  LevelObject
  func jsonStringFromLevelName(levelName: String) throws -> String
  func alertErrorForError(error: FileParserError)
  
//  func levelObjectsFromLevelName(levelName: String) throws -> LevelObject
//  func dataFromFile(levelName: String) throws -> NSDictionary
//  func levelObjectFromDataDic(dataDic: NSDictionary) throws -> LevelObject
//  func levelComponentForDic(component: NSDictionary) throws -> LevelComponent
}


extension FileParserManager {
  
  func levelObjectFromLevelName(levelName: String) throws ->  LevelObject {
    
    let jsonStr = try jsonStringFromLevelName(levelName)
    guard let levelObject = Mapper<LevelObject>().map(jsonStr) else {
      throw FileParserError.BadFormat("Level file failed to be parsed")
    }
    return levelObject
  }

  func jsonStringFromLevelName(levelName: String) throws -> String {
    
    guard let path = NSBundle.mainBundle().pathForResource(levelName, ofType: "json") else {
      throw FileParserError.NotFound("Level file not found")
    }
    guard let jsonStr = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String? else {
      throw FileParserError.Empty("Level file is empty")
    }
    
    return jsonStr
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

//  func levelObjectsFromLevelName(levelName: String) throws -> LevelObject {
//    
//    let dataDic = try self.dataFromFile(levelName)
//    let levelObject = try self.levelObjectFromDataDic(dataDic)
//    return levelObject
//  }
//  
//  
//  func dataFromFile(levelName: String) throws -> NSDictionary  {
//    
//    guard let path = NSBundle.mainBundle().pathForResource(levelName, ofType: "json") else {
//      throw FileParserError.NotFound("Level file not found")
//    }
//    guard let jsonData = NSData(contentsOfFile: path) else {
//      throw FileParserError.Empty("Level file is empty")
//    }
//
//    do {
//      let jsonData = try NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//      return jsonData
//    } catch {
//      throw FileParserError.BadFormat("Level format incorrect")
//    }
//  }
//  
//  
//  func levelObjectFromDataDic(dataDic: NSDictionary) throws -> LevelObject {
//    
//    guard let name = dataDic["name"] as? String else {
//      throw FileParserError.MissingValue("Level name is missing")
//    }
//    guard let size = dataDic["size"] as? NSDictionary else {
//      throw FileParserError.MissingValue("Level size is missing")
//    }
//    guard let width = size["width"] as? Int else {
//      throw FileParserError.MissingValue("Level size width is missing")
//    }
//    guard let height = size["height"] as? Int else {
//      throw FileParserError.MissingValue("Level size height is missing")
//    }
//    guard let dataComponents = dataDic["elements"] as? NSArray else {
//      throw FileParserError.MissingValue("Level elements are missing")
//    }
//    
//    var components: [LevelComponent] = []
//    
//    for component in dataComponents {
//      guard let component = component as? NSDictionary else {
//        throw FileParserError.BadFormat("Level components format incorrect")
//      }
//      components.append(try self.levelComponentForDic(component))
//    }
//    
//    return LevelObject(name: name, size:  LevelSize(width: width, height: height), components: components)
//  }
//  
//  
//  func levelComponentForDic(component: NSDictionary) throws -> LevelComponent {
//    
//    guard let typeInt = component["type"] as? Int else {
//      throw FileParserError.MissingValue("Component type is missing")
//    }
//    guard let type = ComponentType(rawValue: typeInt) else {
//      throw FileParserError.BadFormat("Component type has a bad value")
//    }
//    guard let size = component["position"] as? NSDictionary else {
//      throw FileParserError.MissingValue("Component position is missing")
//    }
//    guard let x = size["x"] as? Int else {
//      throw FileParserError.MissingValue("Component position x is missing")
//    }
//    guard let y = size["y"] as? Int else {
//      throw FileParserError.MissingValue("Component position x is missing")
//    }
//    
//    let z = size["z"] as? Int ?? 1
//    
//    let angleInt = size["angle"] as? Int ?? 0
//    guard let angle = ComponentAngle(rawValue: angleInt) else {
//      throw FileParserError.BadFormat("Component angle has a bad value")
//    }
//    
//    return LevelComponent(type: type, position: ComponentPosition(x: x, y: y, z: z), angle: angle)
//  }
//  
//
}