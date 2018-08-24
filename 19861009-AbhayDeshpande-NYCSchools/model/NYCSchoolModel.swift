//
//  NYCSchoolModel.swift
//  19861009-AbhayDeshpande-NYCSchools
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
/*
NYC Heigh school Obj
@dbn,@name... params can be extended.
*/
struct NYCSchool {
  var dbn: String
  var name: String
  var overview: String
  var location: String
  var phone: String
  var email: String
  var website: String
}

//SAT SCORE
struct NYCSchoolSATScore {
  var mathScore: String
  var readingScore: String
  var writingScore: String
}
