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
    // n'instancier qu'une fois avec du lazy ou un let
    var worldModel : WorldModel? {
        let worldPath = NSBundle.mainBundle().pathForResource("world001", ofType: "json")
        do {
            let tmpWorldModel : WorldModel = try WorldModel().objectForFile(worldPath!)
            print(tmpWorldModel.debugDescription)
            return tmpWorldModel
        } catch {
            print(error);
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// UITableViewDelegate
extension LevelSelectorViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let level : BaseLevelModel = (worldModel?.levels[indexPath.row])!
        let gameViewController = GameViewController(levelName: level.levelFilename)
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
}

// UITableViewDataSource
extension LevelSelectorViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (worldModel?.levels.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let level : BaseLevelModel = (worldModel?.levels[indexPath.row])!
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomDumbCell.cellIdentifier(), forIndexPath: indexPath) as! CustomDumbCell
        cell.mainlabel.text = level.name
        return cell
    }
}


class CustomDumbCell : UITableViewCell {
    
    @IBOutlet weak var mainlabel: UILabel!
    
    static func cellIdentifier() -> String {
        return "CustomDumbCellID"
    }
}