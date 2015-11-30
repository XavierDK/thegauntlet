//
//  GameViewController.swift
//  TheGauntlet
//
//  Created by Xavier De Koninck on 14/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameViewController: UIViewController, FileManager {
  
  let levelManager: LevelManager = LevelManager()
  var scene: SKScene?
  
  init(levelName: String) {
    
    super.init(nibName:nil, bundle:nil)
    
    do {
      let levelObject = try self.levelObjectFromLevelName(levelName)
      self.scene = self.levelManager.levelFromLevelObject(levelObject)
    }
    catch let error as FileError {
      self.alertErrorForError(error)
    }
    catch {
      let alert = UIAlertController(title: "Error", message: "An error occured", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        
      }))
      UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("")
  }
  
  override func loadView() {
    
    let view = SKView(frame: UIScreen.mainScreen().bounds)
    self.view = view
    
    self.view.multipleTouchEnabled = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let scene = scene {
      
      // Configure the view.
      //      scene.scaleMode = .Fill
      
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      
      
      skView.presentScene(scene)
    }
  }
  
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    // Configure the view.
//    
//      // Create and configure the scene.
//      SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
//      scene.scaleMode = SKSceneScaleModeAspectFill;
//      
//      // Present the scene.
//      [skView presentScene:scene];
//    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}

