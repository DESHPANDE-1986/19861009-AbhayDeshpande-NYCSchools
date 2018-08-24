//
//  _9861009_AbhayDeshpande_NYCSchoolsTests.swift
//  19861009-AbhayDeshpande-NYCSchoolsTests
//
//  Created by Deshpande, Abhay(AWF) on 8/23/18.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
@testable import _9861009_AbhayDeshpande_NYCSchools

class _9861009_AbhayDeshpande_NYCSchoolsTests: XCTestCase {
  
  func testGetSchools() {
    var qResult: [AnyObject]?
    
    // Create an expectation
    let expectation = self.expectation(description: "fetchSchoolData")
    NYCSchoolOperation.getServerData(.school, success: { result in
      qResult = result
      XCTAssertNotNil(qResult)

      expectation.fulfill()
    }) { _ in
      XCTFail()
    }
    
    waitForExpectations(timeout: 20, handler: nil)
    XCTAssertNotNil(qResult)
  }
  
  func testGetSATScore() {
    var qResult: [AnyObject]?
    let dbn = "02M260"
    
    // Create an expectation
    let expectation = self.expectation(description: "fetchSchoolData")
    NYCSchoolOperation.getServerData(.score(dbn), success: { result in
      qResult = result
      XCTAssertNotNil(qResult)
      
      expectation.fulfill()
    }) { _ in
      XCTFail()
    }
    
    waitForExpectations(timeout: 20, handler: nil)
    XCTAssertNotNil(qResult)
  }
}
