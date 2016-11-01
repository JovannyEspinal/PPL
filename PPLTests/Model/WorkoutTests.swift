//
//  WorkoutTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class WorkoutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeWorkoutTypeAndExercisesAndDate() {
        let deadlift = Exercise(name: ExerciseNames.deadlift, weight: 135.0, numberOfSets: 1, numberOfReps: 5)
        
        let latPulldown = Exercise(name: ExerciseNames.pulldown, weight: 85.0, numberOfSets: 3, numberOfReps: 12)
       
        let seatedCableRow = Exercise(name: ExerciseNames.seatedCableRow, weight: 85, numberOfSets: 3, numberOfReps: 12)
        
        let exercises = [deadlift, latPulldown, seatedCableRow]
        
        let workout = Workout(type: .pull, exercises: exercises)
        let date = workout.date
        
        XCTAssertEqual(workout.type, .pull)
        XCTAssertEqual(exercises.first!, workout.exercises.first!)
        XCTAssertEqual(workout.date, date)
    }
}

