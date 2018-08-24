//
//  NYCSDetailTableViewCell.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NYCSDetailTableViewCell: UITableViewCell {
  
  @IBOutlet var info: UILabel!
  
  // MARK: Cell Configuration
  func configurateTheCell(_ infoText: String?) {
    if let info = infoText {
      self.info.text = info
    }
  }
}

