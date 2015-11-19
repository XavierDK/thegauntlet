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

class GameViewController: UIViewController {
  
  let fileParserManager: FileParserManager = FileParserManager()
  let levelManager: LevelManager = LevelManager()
  let scene: SKScene?
  
  init(levelName: String) {
    
    let levelObject = self.fileParserManager.levelObjectsFromLevelName(levelName)
    
    guard let levelObj = levelObject else {
      fatalError("Level Object should not be nil")
    }
    self.scene = self.levelManager.levelFromLevelObject(levelObj)
    super.init(nibName:nil, bundle:nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("")
  }
  
  override func loadView() {
    let view = SKView(frame: UIScreen.mainScreen().bounds)
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let scene = scene {
      
      // Configure the view.
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .AspectFill
      
      skView.presentScene(scene)
    }
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.All
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}


extension SKNode {
  
  class func unarchiveFromFile(file : String) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
      let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
      let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
  
}