//
//  ExerciseFactoryTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/13/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class ExerciseFactoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialPullExercises() {
        let pullExercises = ExerciseFactory.initialPullExercises()
        
        let deadlift = Exercise(name: ExerciseNames.deadlift, weight: 90.0, numberOfSets: 1, numberOfReps: 5)
        
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        let seatedCableRow = Exercise(name: ExerciseNames.seatedCableRow, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        XCTAssertEqual(pullExercises[0], deadlift)
        
        XCTAssertEqual(pullExercises[1], pulldown)
        
        XCTAssertEqual(pullExercises[2], seatedCableRow)
    }
    
    func testInitialPushExercises() {
        let pushExercises = ExerciseFactory.initialPushExercises()
        
        let benchPress = Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        
        let overheadPress = Exercise(name: ExerciseNames.overheadPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        let inclineDumbbellPress = Exercise(name: ExerciseNames.inclineDumbellPress, weight: 15, numberOfSets: 3, numberOfReps: 12)
        
        XCTAssertEqual(pushExercises[0], benchPress)
        
        XCTAssertEqual(pushExercises[1], overheadPress)
        
        XCTAssertEqual(pushExercises[2], inclineDumbbellPress)
    }
    
    func testInitialLegExercises() {
        let legExercises = ExerciseFactory.initialLegExercises()
        
        let squat = Exercise(name: ExerciseNames.squat, weight: 135.0, numberOfSets: 3, numberOfReps: 5)
        
        let romanianDeadlift = Exercise(name: ExerciseNames.romanianDeadlift, weight: 135.0, numberOfSets: 3, numberOfReps: 12)
        
        let legPress = Exercise(name: ExerciseNames.legPress, weight: 225.0, numberOfSets: 3, numberOfReps: 12)
        
        XCTAssertEqual(legExercises[0], squat)
        
        XCTAssertEqual(legExercises[1], romanianDeadlift)
        
        XCTAssertEqual(legExercises[2], legPress)
    }
    
    func testInitialAltPullExercises() {
        let pullWorkout = WorkoutFactory.initialPullWorkout()
        
        WorkoutManager.manager.add(pullWorkout)
        
        let altPullWorkout = ExerciseFactory.initialAlternatePullExercises()
        
        let barbellRow = Exercise(name: ExerciseNames.barbellRow, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        
        XCTAssertEqual(altPullWorkout[0], barbellRow)
        
    }
    
}
