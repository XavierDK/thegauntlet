//
//  UserActionsManager.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 17/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import UIKit

enum ActionType {
  case ActionRightMove
  case ActionLeftMove
  case ActionUpMove
  case ActionDownMove
  case ActionTouchPressed
  
  static func actionForTouches(touchStart: CGPoint, touchEnd: CGPoint) -> ActionType {
    
    let v = CGVector(dx: touchStart.x - touchEnd.x, dy: touchStart.y - touchEnd.y)
    let angle = atan2(v.dy, v.dx)
    let deg = angle * CGFloat(180 / M_PI) + 180
    
    print("Angle: \(deg), X: \(v.dx), Y: \(v.dy)")
    
    if abs(v.dx) + abs(v.dy) < 50 {
      return ActionTouchPressed
    }
      
    else if (deg <= 45.0 || deg >= 315.0) {
      return ActionRightMove
    }
      
    else if (deg <= 315.0 && deg >= 225.0) {
      return ActionDownMove
    }
    
    else if (deg <= 225.0 && deg >= 135.0) {
      return ActionLeftMove
    }
    
    else if (deg <= 135.0 && deg >= 45.0) {
      return ActionUpMove
    }
    
    return ActionTouchPressed
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
    return items.removeLast()
  }
}

class ActionsManager {
  
  var moveActionsStack: ActionsStack = ActionsStack()
  var actionsStack: ActionsStack = ActionsStack()
  
  var touchStart: CGPoint = CGPointZero
  
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
  
  func touchBeganForLocation(location: CGPoint) {
    self.touchStart = location
  }
  
  func touchEndedForLocation(location: CGPoint) {
    
    let action = ActionType.actionForTouches(self.touchStart, touchEnd: location)
    
    if action == .ActionTouchPressed {
      self.actionsStack.push(action)
    }
    else {
      self.moveActionsStack.push(action)
    }
    self.touchStart = CGPointZero
  }

}

