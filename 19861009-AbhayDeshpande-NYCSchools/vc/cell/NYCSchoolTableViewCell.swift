//
//  NYCSchoolTableViewCell.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NYCSchoolTableViewCell: UITableViewCell {

  @IBOutlet var nameLabel: UILabel!
  
  // MARK: Cell Configuration
  func configurateTheCell(_ name: String) {
    self.nameLabel.text = name
  }
}
