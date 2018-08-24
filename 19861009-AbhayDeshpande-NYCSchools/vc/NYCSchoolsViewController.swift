//
//  ViewController.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import LLSpinner

class NYCSchoolsViewController: UITableViewController {
  
  let identifier: String = "nycSchoolTableViewCell"
  
  private var nycSchoolNames = [NYCSchool]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    title = "NYC High Schools"
    navigationController?.navigationBar.prefersLargeTitles = true
    getNYCSchools()
  }
  
  private func getNYCSchools() {
    LLSpinner.spin(style: .gray, backgroundColor: .white)
    NYCSchoolOperation.getNYCHeighSchoolsOperation(completion: { [weak self] result in
      LLSpinner.stop()
      
      guard let result = result else {
        return
      }
      
      self?.nycSchoolNames = result
      self?.tableView.reloadData()
    }) { error in
      LLSpinner.stop()
    }
  }
}

extension NYCSchoolsViewController {
  
  // MARK: UITableView DataSource
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NYCSchoolTableViewCell {
      let name = nycSchoolNames[indexPath.row].name
      cell.configurateTheCell(name)
      return cell
    }
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nycSchoolNames.count
  }
}

extension NYCSchoolsViewController {
  
  // MARK: Segue Method
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "schoolDetail",
      let indexPath = self.tableView?.indexPathForSelectedRow,
      let destinationViewController: NYCSDetailsViewController = segue.destination as? NYCSDetailsViewController {
      let school = nycSchoolNames[indexPath.row]
      destinationViewController.school = school
    }
  }
}
