//
//  NYCSchoolOperation.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

/**
 NYCSchoolOperation
 **Fetch Heigh Schools
 - getNYCHeighSchoolsOperation(...)
 **Fetch SAT score
 - getNYCSchoolSATScoreOperation(...)
 **common entrypoint of network operations
 - getServerData(...)
**/

class NYCSchoolOperation {
  
  typealias NYCSchoolHandler = ([NYCSchool]?) -> Void
  typealias NYCSchoolSATScoreHandler = (NYCSchoolSATScore?) -> Void
  
  static func getNYCHeighSchoolsOperation(completion:@escaping NYCSchoolHandler, failure:@escaping (Error?)->Void) {
    
    getServerData(.school, success: { result in
      guard let result = result else {
        completion(nil)
        return
      }
      
      var schools = [NYCSchool]()
      
      result.forEach{ detail in
        if let dbn = detail["dbn"] as? String, let overview = detail["overview_paragraph"] as? String, let name = detail["school_name"] as? String, let location = detail["location"] as? String, let phone = detail["phone_number"] as? String,  let email = detail["school_email"] as? String, let website = detail["website"] as? String {
          
          let school = NYCSchool(dbn: dbn, name: name, overview: overview, location: location, phone: phone, email: email, website: website)
          schools.append(school)
        }
        
        completion(schools)
      }
    }, failure:{ error in
      failure(error)
    })
  }
  
  static func getNYCSchoolSATScoreOperation(for dbn: String, completion:@escaping NYCSchoolSATScoreHandler, failure:@escaping (Error?)->Void) {
    
    getServerData(.score(dbn), success: { result in
      
      guard let detail = result?.first as? [String: String], let mathScore = detail["sat_math_avg_score"], let readingScore = detail["sat_critical_reading_avg_score"],  let writingScore = detail["sat_writing_avg_score"] else {
        completion(nil)
        return
      }
      
      let nycSchoolSATScore = NYCSchoolSATScore(mathScore: mathScore, readingScore: readingScore, writingScore: writingScore)
      
      completion(nycSchoolSATScore)
      
    }, failure:{ error in
      failure(error)
    })
  }
  
  static func getServerData(_ type: QueryType, success:@escaping ([AnyObject]?) -> Void, failure:@escaping (Error?)->Void) {
    
    guard let url = URL(string: "\(hostURL)\(type.endPoint)") else {
      failure(nil)
      return
    }
    
    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared
    
    let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
      
      // make sure we get the data
      guard let responseData = data else {
        DispatchQueue.main.async {
          failure(error)
        }
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [AnyObject]
        
        DispatchQueue.main.async {
          success(json)
        }
      } catch  {
        print("error trying to convert data to JSON") //adding print just to make sure to log the response
        return
      }
    })
    task.resume()
  }
}
