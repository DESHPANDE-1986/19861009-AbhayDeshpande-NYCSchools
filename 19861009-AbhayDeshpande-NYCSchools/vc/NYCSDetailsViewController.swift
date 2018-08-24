//
//  NYCSchoolsViewController.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import LLSpinner

class NYCSDetailsViewController: UITableViewController {
  
  let identifier: String = "nycSDetailTableViewCell"
  
  var school: NYCSchool? //open param
  
  private var detailSections = ["NAME", "SAT SCORE", "OVERVIEW PARAGRAPH","ADDRESS", "PHONE", "EMAIL", "WEBSITE"]
  private var nycsSATScore: NYCSchoolSATScore?
  
  private var headerImages: [UIImage] {
    var images = [UIImage]()
    
    for i in 1..<6 {
      let image = UIImage(named: "HS\(i)")!
      images.append(image)
    }
    
    return images
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Overview"
    getSATScore()
  }
  
  private func getSATScore() {
    LLSpinner.spin()
    
    let dbn = school?.dbn ?? ""
    NYCSchoolOperation.getNYCSchoolSATScoreOperation(for: dbn, completion: { [weak self] result in
      if let result = result {
        self?.nycsSATScore = result
      }
      
      self?.tableView.reloadData()
      LLSpinner.stop()
      
    }) { error in
      LLSpinner.stop()
    }
    
  }
}

extension NYCSDetailsViewController {
  
  // MARK: UITableView DataSource
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return detailSections[section]
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return detailSections.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NYCSDetailTableViewCell {
      let info: String?
      
      switch  detailSections[indexPath.section] {
      case "NAME":
        info = school?.name
      case "SAT SCORE":
        
        //SAT SCORE
        switch indexPath.row {
        case 0:
          let score = nycsSATScore?.mathScore ?? "N/A"
          info = "SAT MATH AVG SCORE: \(score)"
        case 1:
          let score = nycsSATScore?.readingScore ?? "N/A"
          info = "SAT CRITICAL READING AVG SCORE: \(score)"
        case 2:
          let score = nycsSATScore?.writingScore ?? "N/A"
          info = "SAT WRITING AVG SCORE: \(score)"
        default:
          info = nil
        }
        
      case "OVERVIEW PARAGRAPH":
        info = school?.overview ?? "N/A"
      case "ADDRESS":
        info = school?.location ?? "N/A"
      case "PHONE":
        info = school?.phone
      case "EMAIL":
        info = school?.email
      case "WEBSITE":
        info = school?.website
      default:
        info = nil
      }
      
      cell.configurateTheCell(info)
      
      return cell
    }
    
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //Number of rows defer in case of SCORE
    if detailSections[section] == "SAT SCORE" {
      return 3
    }
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    //assuming that there is only one section for now.
    
    if section == 0 {
      
      let imageView: UIImageView = UIImageView()
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleAspectFill
      let headerImage = headerImages[Int(arc4random_uniform(UInt32(headerImages.count)))]

      imageView.image =  headerImage
      return imageView
    }
    
    return nil
    
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
    if section == 0 {
        return view.frame.height / 3
    }
    
    return UITableViewAutomaticDimension
    
  }
}
