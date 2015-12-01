//
//  CustomOperator.swift
//  LevelHandler
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 jeff. All rights reserved.
//

import Foundation

// if let custom operator
infix operator ?= { associativity right precedence 90 }

func ?=<T>(inout left: T, right: T?) {
    if let value = right {
        left = value
    }
}

func ?=<T>(inout left: T?, right: T?) {
    if let value = right {
        left = value
    }
}
