//
//  JSONModelParser.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 18/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

enum JSONModelParserError: ErrorType {
    
    case NotFound(String)
    case BadFormat(String)
    case Empty(String)
    case MissingValue(String)
}


protocol JSONModelParser {
    func objectForFile<T : Mappable>(filePath: String) throws -> T
    func alertErrorForError(error: JSONModelParserError)
}


extension JSONModelParser {
    
    func objectForFile<T : Mappable> (filePath: String) throws -> T {
        let jsonStr = try jsonStringFromFile(filePath)
        guard let parsedObject = Mapper<T>().map(jsonStr) else {
            throw JSONModelParserError.BadFormat("\(filePath) failed to be parsed")
        }
        
        do {
         try parsedObject.checkMappedDataValidity()
            return parsedObject
        } catch {
            throw JSONModelParserError.MissingValue(" Missing value in \(filePath)")
        }
    }
    
    func jsonStringFromFile(filePath: String) throws -> String {
        guard NSFileManager().fileExistsAtPath(filePath) else {
            throw JSONModelParserError.NotFound("\(filePath) file not found")
        }
        guard let jsonStr = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String? else {
            throw JSONModelParserError.Empty("\(filePath) file is empty")
        }
        return jsonStr
    }
    
    func alertErrorForError(error: JSONModelParserError) {
        
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