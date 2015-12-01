//
//  UserActionsManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 17/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import UIKit
import SpriteKit

enum ActionType {
  
  case ActionRightMove
  case ActionLeftMove
  case ActionUpMove
  case ActionDownMove
  case ActionTouchPressed
  
//  static func actionForTouches(touchStart: CGPoint, touchEnd: CGPoint) -> ActionType {
//    
//    let v = CGVector(dx: touchStart.x - touchEnd.x, dy: touchStart.y - touchEnd.y)
//    let angle = atan2(v.dy, v.dx)
//    let deg = angle * CGFloat(180 / M_PI) + 180
//    
//    //    print("Angle: \(deg), X: \(v.dx), Y: \(v.dy)")
//    
//    if abs(v.dx) + abs(v.dy) < 20 {
//      return ActionTouchPressed
//    }
//      
//    else if (deg <= 45.0 || deg >= 315.0) {
//      return ActionRightMove
//    }
//      
//    else if (deg <= 315.0 && deg >= 225.0) {
//      return ActionDownMove
//    }
//      
//    else if (deg <= 225.0 && deg >= 135.0) {
//      return ActionLeftMove
//    }
//      
//    else if (deg <= 135.0 && deg >= 45.0) {
//      return ActionUpMove
//    }
//    
//    return ActionTouchPressed
//  }
  
  
  static func actionForSwipeDirection(direction: UISwipeGestureRecognizerDirection) -> ActionType {
    
    switch direction {
      
    case UISwipeGestureRecognizerDirection.Up:
      return .ActionUpMove
    case UISwipeGestureRecognizerDirection.Down:
      return .ActionDownMove
    case UISwipeGestureRecognizerDirection.Left:
      return .ActionLeftMove
    case UISwipeGestureRecognizerDirection.Right:
      return .ActionRightMove
      
    default:
      return .ActionTouchPressed
    }
  }
  
}


struct ActionsStack {
  
  var items = [ActionType]()
  
  mutating func push(item: ActionType) {
    
    items.append(item)
  }
  mutating func pop() -> ActionType? {
    
    if items.count == 0 {
      return nil
    }
    return items.removeFirst()
  }
}


struct ActionToLaunch: Hashable, Equatable {
  
  let node: SKNode
  let action: SKAction
  
  var hashValue: Int {
    return "\(node)\(action)".hashValue
  }
}

func ==(lhs: ActionToLaunch, rhs: ActionToLaunch) -> Bool {
  
  if lhs.action == rhs.action && lhs.node == rhs.node {
    return true
  }
  return false
}


class ActionsManager {
  
  var moveActionsStack: ActionsStack = ActionsStack()
  var actionsStack: ActionsStack = ActionsStack()
  var actionsToLaunch: Set<ActionToLaunch> = Set<ActionToLaunch>()
//  var touchStart: CGPoint = CGPointZero
  
  
  func resetStacks() {
    
    self.actionsStack = ActionsStack()
    self.moveActionsStack = ActionsStack()
  }
  
  func nextAction() -> ActionType? {
    
    return self.actionsStack.pop()
  }
  
  func nextMoveAction() -> ActionType? {
    
    return self.moveActionsStack.pop()
  }
  
  func addActionForDirection(direction: UISwipeGestureRecognizerDirection) {
    
    let action = ActionType.actionForSwipeDirection(direction)
    
    if action == .ActionTouchPressed {
      
      self.actionsStack.push(action)
    }
    else {
      if self.moveActionsStack.items.count < GameConstant.Player.Actions.MaxStackActions - 1 {
        self.moveActionsStack.push(action)
      }
    }

  }
  
//  func resetTouch() {
//    
//    self.touchStart = CGPointZero
//  }
//  
//  func touchBeganForLocation(location: CGPoint) {
//    
//    self.touchStart = location
//  }
//  
//  func touchEndedForLocation(location: CGPoint) {
//    
//    let action = ActionType.actionForTouches(self.touchStart, touchEnd: location)
//    if action == .ActionTouchPressed {
//      
//      self.actionsStack.push(action)
//    }
//    else {
//      if self.moveActionsStack.items.count < GameConstant.Player.Actions.MaxStackActions - 1 {
//        self.moveActionsStack.push(action)
//      }
//    }
//    self.touchStart = CGPointZero
//  }
  
  func addActionToLaunch(action: SKAction, forNode node: SKNode) {
    
    self.actionsToLaunch.insert(ActionToLaunch(node: node, action: action))
  }
  
  func clearActionsToLauch() {
    
    self.actionsToLaunch.removeAll()
  }
  
  func actionsToLauch() -> Set<ActionToLaunch>{
    
    return self.actionsToLaunch
  }
}

