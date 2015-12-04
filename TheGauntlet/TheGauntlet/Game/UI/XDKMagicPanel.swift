//
//  XDKRotatingPanel.swift
//  XDKRotatingPanel
//
//  Created by Xavier De Koninck on 03/12/2015.
//  Copyright © 2015 Xavier De Koninck. All rights reserved.
//

import Foundation
import UIKit


protocol XDKMagicPanelDelegate {
  
  func numberOfItemsForMagicPanel(panel: XDKMagicPanel) -> Int
  func magicButtonForPanel(panel: XDKMagicPanel, index: Int) -> XDKMagicPanelButton
}

extension XDKMagicPanelDelegate {
  
  func numberOfItemsForMagicPanel(panel: XDKMagicPanel) -> Int {
    return 0
  }
}


class XDKMagicPanel: UIView {
  
  var delegate: XDKMagicPanelDelegate?
  
  let marginRight: CGFloat = 40.0
  let marginBottom: CGFloat = 40.0
  let buttonSize: CGFloat = 60.0
  var buttonsNumber: Int?
  
  var buttons: [UIButton]
  
  override init(frame: CGRect) {
    
    self.buttons = [UIButton]()
    
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.yellowColor()
    self.alpha = 0.5
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func loadPanel() {
    
    self.createButtons()
    self.addOpeningButton()
  }
  
  func createButtons() {
    
    self.buttonsNumber = self.delegate?.numberOfItemsForMagicPanel(self)
    
    if let buttonsNumber = self.buttonsNumber {
      for _ in 0 ..< buttonsNumber {
        
        let button = UIButton(type: .Custom)
        self.buttons.append(button)
        
//        self.addSubview(button)
//        
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[button(buttonSize)]-marginBottom-|", options: .DirectionLeadingToTrailing, metrics: ["buttonSize": buttonSize, "marginBottom": marginBottom], views: ["button": button]))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button(buttonSize)]-marginRight-|", options: .DirectionLeadingToTrailing, metrics: ["buttonSize": buttonSize, "marginRight": marginRight], views: ["button": button]))
      }
    }
  }
  
  func addOpeningButton() {
    
    let button = UIButton(type: .Custom)
    
    button.backgroundColor = UIColor.blackColor()
    self.addSubview(button)
    
    button.layer.cornerRadius = buttonSize/2
    button.layer.masksToBounds = true;
    
    self.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self, action: "openingButtonClick:", forControlEvents: .TouchDown)
    
    if let superview = self.superview {
      superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["view": self]))
      superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["view": self]))
    }
    
    self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[button(buttonSize)]-marginBottom-|", options: .DirectionLeadingToTrailing, metrics: ["buttonSize": buttonSize, "marginBottom": marginBottom], views: ["button": button]))
    self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button(buttonSize)]-marginRight-|", options: .DirectionLeadingToTrailing, metrics: ["buttonSize": buttonSize, "marginRight": marginRight], views: ["button": button]))
  }
  
  
  func openingButtonClick(sender: UIButton){
    
  }
}


class XDKMagicPanelButton: UIView {
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.layer.cornerRadius = 45.0
    self.layer.masksToBounds = true;
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}