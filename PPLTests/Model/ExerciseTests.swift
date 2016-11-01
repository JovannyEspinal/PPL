//
//  ExerciseTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class ExerciseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeNameAndWeightAndNumberOfSetsAndNumberOfReps() {
        let exercise = Exercise(name: ExerciseNames.deadlift, weight: 135.0, numberOfSets: 1, numberOfReps: 5)
        
        XCTAssertEqual(exercise.name, "Deadlift")
        XCTAssertEqual(exercise.weight, 135.0)
        XCTAssertEqual(exercise.sets.count, 1)
        XCTAssertEqual(exercise.sets.first!.numberOfReps, 5)
    }
    
    func testEqualExercises_ShouldBeEqual() {
        let exercise1 = Exercise(name: ExerciseNames.deadlift, weight: 135.0, numberOfSets: 1, numberOfReps: 5)
        let exercise2 = Exercise(name: ExerciseNames.deadlift, weight: 135.0, numberOfSets: 1, numberOfReps: 5)
        
        XCTAssertEqual(exercise1, exercise2)
    }
    
    func testWhenNameDiffers_ShouldBeNotEqual() {
        performNotEqual(firstName: ExerciseNames.deadlift, firstWeight: 135.0, firstNumberOfSets: 1, firstNumberOfReps: 5, secondName: ExerciseNames.benchPress, secondWeight: 135.0, secondNumberOfSets: 1, secondNumberOfReps: 5)
    }
    
    func testWhenWeightDiffers_ShouldBeNotEqual() {
        performNotEqual(firstName: ExerciseNames.deadlift, firstWeight: 135.0, firstNumberOfSets: 1, firstNumberOfReps: 5, secondName: ExerciseNames.deadlift, secondWeight: 225.0, secondNumberOfSets: 1, secondNumberOfReps: 5)
    }
    
    func testWhenNumberOfSetsDiffers_ShouldBeNotEqual() {
        performNotEqual(firstName: ExerciseNames.deadlift, firstWeight: 135.0, firstNumberOfSets: 1, firstNumberOfReps: 5, secondName: ExerciseNames.deadlift, secondWeight: 135.0, secondNumberOfSets: 5, secondNumberOfReps: 5)
    }
    
    func testWhenNumberOfRepsDiffers_ShouldBeNotEqual() {
        performNotEqual(firstName: ExerciseNames.deadlift, firstWeight: 135.0, firstNumberOfSets: 1, firstNumberOfReps: 5, secondName: ExerciseNames.deadlift, secondWeight: 135.0, secondNumberOfSets: 1, secondNumberOfReps: 3)
    }
    
    func performNotEqual(firstName: String, firstWeight: Double, firstNumberOfSets: Int, firstNumberOfReps: Int, secondName: String, secondWeight: Double, secondNumberOfSets: Int, secondNumberOfReps: Int, line: UInt = #line) {
        let exercise1 = Exercise(name: firstName, weight: firstWeight, numberOfSets: firstNumberOfSets, numberOfReps: firstNumberOfReps)
        let exercise2 = Exercise(name: secondName, weight: secondWeight, numberOfSets: secondNumberOfSets, numberOfReps: secondNumberOfReps)
        
        XCTAssertNotEqual(exercise1, exercise2)
    }
    
    func testHasCompletedAllSetsWhenSetsHaveNotBeenCompleted_ShouldBeFalse() {
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        XCTAssertFalse(pulldown.hasCompletedAllSets())
    }
    
    func testHasCompletedAllSetsWhenAllSetsHaveNotMetRepGoal_ShouldBeFalse() {
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        let updatedPulldown = pulldown |> Exercise.setsLens *~ simulateSetCompletion(withStatus: .incomplete, forExercise: pulldown)
        
        XCTAssertFalse(updatedPulldown.hasCompletedAllSets())
    }
    
    func testHasCompletedAllSetsWhenAllSetsHaveMetRepGoal_ShouldBeTrue() {
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        let updatedPulldown = pulldown |> Exercise.setsLens *~ simulateSetCompletion(withStatus: .completed, forExercise: pulldown)
        
        XCTAssertTrue(updatedPulldown.hasCompletedAllSets())
    }
}

extension ExerciseTests {
    enum SetStatus {
        case completed
        case incomplete
    }
    
    func simulateSetCompletion(withStatus status: SetStatus, forExercise exercise: Exercise) -> [ExerciseSet] {
        let numberOfRepsCompleted: Int
        var updatedSet = [ExerciseSet]()
        
        switch status {
        case .completed:
            numberOfRepsCompleted = exercise.sets.first!.numberOfReps
        case .incomplete:
            numberOfRepsCompleted = Int(arc4random_uniform(UInt32(exercise.sets.first!.numberOfReps)))
        }
        
        for i in 0..<exercise.sets.count {
            let set = (exercise |> Exercise.setsLens.get)[i] |> ExerciseSet.numberOfRepsCompletedLens *~ numberOfRepsCompleted
            updatedSet.append(set)
        }
        
        return updatedSet
    }
}


