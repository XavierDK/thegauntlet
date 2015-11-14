//
//  LevelSelectorViewController.swift
//  TheGauntlet
//
//  Created by Jeffrey Macko on 13/11/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import UIKit

// UIViewController
class LevelSelectorViewController: UITableViewController {

}

// UITableViewDelegate
extension LevelSelectorViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

// UITableViewDataSource
extension LevelSelectorViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomDumbCell.cellIdentifier(), forIndexPath: indexPath) as! CustomDumbCell
        cell.mainlabel.text = "Niveau \(indexPath.row)"
        return cell
    }
}


class CustomDumbCell : UITableViewCell {
    
    @IBOutlet weak var mainlabel: UILabel!
    
    static func cellIdentifier() -> String {
        return "CustomDumbCellID"
    }
}