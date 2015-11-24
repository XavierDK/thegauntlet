//
//  ViewController.swift
//  TheGauntlet
//
//  Created by Jeffrey Macko on 09/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  override func shouldAutorotate() -> Bool {
    
    return true
  }

}

// Crashlytics
import Crashlytics

extension ViewController {
    
    @IBAction func crashAction(sender: UIButton) {
        Crashlytics.sharedInstance().crash()
    }
}
