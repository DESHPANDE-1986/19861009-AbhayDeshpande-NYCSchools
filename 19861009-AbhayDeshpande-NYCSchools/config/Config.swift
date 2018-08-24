//
//  URLConfig.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

let hostURL = "https://data.cityofnewyork.us"

/*
 Query type used as a dependecy injection for api query @school or @score
 */

enum QueryType {
  case school
  case score(String)
  
  var endPoint: String {
    switch self {
    case .school:
      return "/resource/97mf-9njv.json"
    case .score(let dbn):
      return "/resource/734v-jeq5.json?dbn=\(dbn)"
      
    }
  }
}
