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
  
  func levelObjectFromLevelName(levelName: String) throws -> LevelObject
  func jsonStringFromLevelName(levelName: String) throws -> String
  func checkLevelValidityForLevelObject(levelObject: LevelObject) throws -> LevelObject
  func alertErrorForError(error: FileParserError)
}


extension FileParserManager {
  
  func levelObjectFromLevelName(levelName: String) throws -> LevelObject {
    
    let jsonStr = try jsonStringFromLevelName(levelName)
    guard var levelObject = Mapper<LevelObject>().map(jsonStr) else {
      throw FileParserError.BadFormat("Level file failed to be parsed")
    }
    levelObject = try self.checkLevelValidityForLevelObject(levelObject)
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

  func checkLevelValidityForLevelObject(var levelObject: LevelObject) throws -> LevelObject {
    
    if levelObject.name == nil {
      throw FileParserError.MissingValue("Level name is missing")
    }
    if levelObject.size == nil {
      throw FileParserError.MissingValue("Level size is missing")
    }
    if levelObject.size.width == nil {
      throw FileParserError.MissingValue("Level size width is missing")
    }
    if levelObject.size.height == nil {
      throw FileParserError.MissingValue("Level size height is missing")
    }
    if levelObject.components == nil {
      throw FileParserError.MissingValue("Level componenets are missing")
    }
    
    for index in 0..<levelObject.components.count {
      
      if levelObject.components[index].type == nil {
        throw FileParserError.MissingValue("Component type is missing")
      }
      if levelObject.components[index].position == nil {
        throw FileParserError.MissingValue("Component position is missing")
      }
      if levelObject.components[index].position.x == nil {
        throw FileParserError.MissingValue("Component position x is missing")
      }
      if levelObject.components[index].position.y == nil {
        throw FileParserError.MissingValue("Component position y is missing")
      }
      if levelObject.components[index].position.z == nil {
        levelObject.components[index].position.z = 3
      }
      if levelObject.components[index].angle == nil {
        levelObject.components[index].angle = ComponentAngle.Top
      }
    }
    return levelObject
  }
}