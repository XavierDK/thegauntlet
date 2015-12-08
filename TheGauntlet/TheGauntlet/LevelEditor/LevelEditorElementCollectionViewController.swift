//
//  LevelEditorElementCollectionViewController.swift
//  TheGauntlet
//
//  Created by jeff on 07/12/2015.
//  Copyright © 2015 Jeffrey Macko. All rights reserved.
//

import UIKit

// un array de section
// un array de element
typealias ElementsSection = Array<ElementContent>
typealias ElementContent = Array<ElementDetail>
typealias ElementDetail = Array<AnyObject>

struct SectionContent {
  let titleLabel : String
  let content : AnyObject
}

struct CellContent {
  let imageName : String
  let element : ElementModel
}

class LevelEditorElementCollectionViewController : UICollectionViewController {
  var actualLevel : LevelModel = LevelModel()
  let collectionViewData : ElementsSection = ElementsSection()
}

// MARK: CollectionViewData Factory
extension LevelEditorElementCollectionViewController {
  func updateCollectionViewDataForElementID(elementID: String, atIndexPath: NSIndexPath) {
    
    self.collectionView?.reloadData()
  }
}

// MARK: UIViewController
extension LevelEditorElementCollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    self.collectionView?.registerClass(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
//    self.collectionView?.registerClass(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
  }
}

// MARK: UICollectionViewDelegate
extension LevelEditorElementCollectionViewController {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
  }
}

// MARK: UICollectionViewDataSource
extension LevelEditorElementCollectionViewController {

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return self.collectionViewData.count
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let nb : Int? = self.collectionViewData[section].count else {
      return 0
    }
    return nb!
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let withReuseIdentifier : String = "withReuseIdentifier"
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(withReuseIdentifier, forIndexPath: indexPath)
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    let elementKind : String = "LevelEditorSection"
    let withReuseIdentifier : String = "withReuseIdentifier"
    
    let headerCell = collectionView.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: withReuseIdentifier, forIndexPath: indexPath)
    
    return headerCell
  }
}