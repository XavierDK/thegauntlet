//
//  Enums.swift
//  LevelGenerator
//
//  Created by jeff on 30/11/2015.
//  Copyright © 2015 DirtyPixel. All rights reserved.
//

import Foundation


// Grouper les ressources par Type
enum ImageGroupName : Int {
    case User
    case Case
    case Block
    case Item
}

enum Orientation: Int {
    case Up = 180
    case Right = 90
    case Down = 0
    case Left = 270
}

enum BaseType : Int {
    case User = 1
    case Case = 2
    case Block = 3
    case Item = 4
}

enum SpecificTypeUser : Int {
    case In = 1
    case Out = 2
}

enum SpecificTypeCase : Int {
    case Simple = 1
    case Hole = 2
    case Muddy = 3
    case Ephemeral = 4
    case Actionable = 5
}

enum ActionableActionType : Int {
    case Show = 1
    case Hide = 2
}


enum SpecificTypeBlock : Int {
    case Wall = 1
    case Boulder = 2
    case BoulderCracked = 3
    case Tree = 4
    case BurningTree = 5
}

enum SpecificTypeItem : Int {
    case Glove = 1
    case Rope = 2
    case Hammer = 3
    case Axe = 4
    case WaterSeal = 5
}
