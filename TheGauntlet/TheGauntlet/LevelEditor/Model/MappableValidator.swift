//
//  MappableValidator.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation
import ObjectMapper

enum MappableValidatorError : ErrorType {
    case MissingMandatoryValue(String)
}

extension Mappable {
    func checkMappedDataValidity() throws -> Bool { return false }
}
