//
//  WorkoutTypeTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class WorkoutTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeWorkoutType() {
        let pullWorkoutType = WorkoutType.pull
        
        XCTAssertEqual(pullWorkoutType, .pull)
    }
}
