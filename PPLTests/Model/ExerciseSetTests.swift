//
//  ExerciseSetTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class ExerciseSetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetNumberOfReps() {
        let set = ExerciseSet(numberOfReps: 5)
    
        XCTAssertEqual(set.numberOfReps, 5)
    }
    
    func testEqualSets_ShouldBeEqual() {
        let set1 = ExerciseSet(numberOfReps: 5)
        let set2 = ExerciseSet(numberOfReps: 5)
        
        XCTAssertEqual(set1, set2)
    }
    
    func testWhenNumberOfRepsDiffer_ShouldBeNotEqual() {
        let set1 = ExerciseSet(numberOfReps: 5)
        let set2 = ExerciseSet(numberOfReps: 3)
        
        XCTAssertNotEqual(set1, set2)
    }
    
    func testInitialNumberOfRepsCompleted_ShouldBeZero() {
        let set = ExerciseSet(numberOfReps: 5)
        
        XCTAssertEqual(set.numberOfRepsCompleted, 0)
    }
    
    func testHasMetRepGoalWhenNumberOfRepsCompletedIsNotEqualToNumberOfReps_ShouldBeFalse() {
        let set = ExerciseSet(numberOfReps: 5)
            
        let updatedSet = set |> ExerciseSet.numberOfRepsCompletedLens *~ 4
        
        XCTAssertFalse(updatedSet.hasMetRepGoal())
    }
    
    func testHasMetRepGoalWhenNumberOfRepsCompletedIsEqualToNumberOfReps_ShouldBeTrue() {
        let set = ExerciseSet(numberOfReps: 5)
            
        let updatedSet = set |> ExerciseSet.numberOfRepsCompletedLens *~ 5
        
        XCTAssertTrue(updatedSet.hasMetRepGoal())
    }
}
