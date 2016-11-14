////
////  WorkoutManagerTests.swift
////  PPL
////
////  Created by Jovanny Espinal on 10/20/16.
////  Copyright © 2016 Jovanny Espinal. All rights reserved.
////
//
//import XCTest
//@testable import PPL
//
//class WorkoutManagerTests: XCTestCase {
//    
//    var sut: WorkoutManager!
//    
//    override func setUp() {
//        super.setUp()
//        sut = WorkoutManager.manager
//        
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//        sut.removeAllWorkouts()
//    }
//    
//    // MARK: Past Workout Tests
//    func testInitialPastWorkoutCount_ShouldBeZero() {
//        XCTAssertEqual(sut.pastWorkoutsCount, 0)
//    }
//    
//    func testPastWorkoutCountAfterAddingAWorkout_ShouldBeOne() {
//        let workout = Workout(type: .pull, exercises: [Exercise]())
//        
//        sut.add(workout)
//        
//        XCTAssertEqual(sut.pastWorkoutsCount, 1)
//    }
//    
//    func testCreateWorkoutWhenPastExercisesAreEmpty_ShouldReturnAPullWorkout() {
//        XCTAssertEqual(sut.pastWorkoutsCount, 0)
//        
//        let workout = sut.createWorkout()
//        
//        XCTAssertEqual(workout.type, .pull)
//    }
//    
//    func testReturnWorkoutAtIndex_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let workoutAtIndex = sut.workout(atIndex: sut.pastWorkoutsCount-2)
//        
//        XCTAssertEqual(workoutAtIndex!, pushWorkout)
//    }
//    
//    // MARK: Test progress update on exercises
//    func testUpdateExercisesWhenBothPullWorkoutsAreCompleted_() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let newPullWorkout = sut.currentWorkout!
//        
//        
//        XCTAssertEqual(newPullWorkout.exercises[0].name, pullWorkout.exercises[0].name)
//        XCTAssertEqual(newPullWorkout.exercises[0].weight, pullWorkout.exercises[0].weight + 10.0)
//        
//        XCTAssertEqual(newPullWorkout.exercises[1].name, altPullWorkout.exercises[1].name)
//        XCTAssertEqual(newPullWorkout.exercises[1].weight, altPullWorkout.exercises[1].weight + 2.5)
//    }
//    
//    func testUpdateExercisesWhenFirstPullWorkoutIsNotCompleted_() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let newPullWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(newPullWorkout.exercises[0].name, pullWorkout.exercises[0].name)
//        XCTAssertNotEqual(newPullWorkout.exercises[0].weight, pullWorkout.exercises[0].weight + 5.0)
//        
//        XCTAssertEqual(newPullWorkout.exercises[1].name, altPullWorkout.exercises[1].name)
//        XCTAssertEqual(newPullWorkout.exercises[1].weight, altPullWorkout.exercises[1].weight + 2.5)
//    }
//    
//    func testUpdateExercisesWhenSecondPullWorkoutIsNotCompleted_() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let newPullWorkout = sut.currentWorkout!
//        
//        
//        XCTAssertEqual(newPullWorkout.exercises[0].name, pullWorkout.exercises[0].name)
//        XCTAssertEqual(newPullWorkout.exercises[0].weight, pullWorkout.exercises[0].weight + 10.0)
//        
//        XCTAssertEqual(newPullWorkout.exercises[1].name, altPullWorkout.exercises[1].name)
//        XCTAssertNotEqual(newPullWorkout.exercises[1].weight, altPullWorkout.exercises[1].weight + 5.0)
//    }
//    
//    func testUpdateExercisesWhenBothPullWorkoutsAreNotCompleted_() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let newPullWorkout = sut.currentWorkout!
//        
//        
//        XCTAssertEqual(newPullWorkout.exercises[0].name, pullWorkout.exercises[0].name)
//        XCTAssertNotEqual(newPullWorkout.exercises[0].weight, pullWorkout.exercises[0].weight + 5.0)
//        
//        XCTAssertEqual(newPullWorkout.exercises[1].name, altPullWorkout.exercises[1].name)
//        XCTAssertNotEqual(newPullWorkout.exercises[1].weight, altPullWorkout.exercises[1].weight + 5.0)
//    }
//    
//    // MARK: Test deload update on exercises
//    func testFailCountWhenExerciseFailed_FailCountShouldBeOne() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let alternatePullWorkout = sut.initialAlternatePullWorkout()
//        
//        XCTAssertEqual(alternatePullWorkout.exercises[1].failCount, 1)
//    }
//    
//    func testFailCountWhenExercisedFailThreeTimes_FailCountShouldBeZeroAndWeightDeloadedByTenPercent() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        sut.add(sut.initialPushWorkout())
//        sut.add(sut.initialLegWorkout())
//        
//        let alternatePullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAlternatePullWorkout = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: alternatePullWorkout)
//        sut.add(updatedAlternatePullWorkout)
//        sut.add(sut.initialAlternatePushWorkout())
//        
//        XCTAssertEqual(alternatePullWorkout.exercises[1].failCount, 1)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        let updatedPullWorkout2 = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: pullWorkout2)
//        sut.add(updatedPullWorkout2)
//        sut.add(sut.initialPushWorkout())
//        sut.add(sut.initialLegWorkout())
//        
//        XCTAssertEqual(pullWorkout2.exercises[1].failCount, 2)
//        
//        let alternatePullWorkout2 = sut.alternatePullWorkout()
//        let updatedAlternatePullWorkout2 = simulateWorkoutCompletion(withStatus: .incomplete, forExercise: alternatePullWorkout2)
//        sut.add(updatedAlternatePullWorkout2)
//        
//        XCTAssertEqual(alternatePullWorkout2.exercises[1].failCount, 0)
//
//        let originalWeight = pullWorkout2.exercises[1].weight
//        let deloadWeight = originalWeight * 0.1
//        
//        XCTAssertEqual(alternatePullWorkout2.exercises[1].weight, round(((originalWeight - deloadWeight) / 2.5)) * 2.5)
//    }
//
//    // MARK: Initial Workout Creation Tests
//    func testInitialPullWorkoutExercisesAndWorkoutType_ShouldBeEqual() {
//        performEqual(firstWorkoutType: .pull,
//                     firstExercise: Exercise(name: ExerciseNames.deadlift, weight: 90.0, numberOfSets: 1, numberOfReps: 5),
//                     secondExercise: Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                     thirdExercise: Exercise(name: ExerciseNames.seatedCableRow, weight: 45, numberOfSets: 3, numberOfReps: 12),
//                     initialWorkout: sut.initialPullWorkout() )
//    }
//    
//    func testInitialPullWorkoutWhenExercisesAndWorkoutTypeDiffer_ShouldBeNotEqual() {
//        performNotEqual(firstWorkoutType: .legs,
//                        firstExercise:  Exercise(name: ExerciseNames.benchPress, weight: 90.0, numberOfSets: 1, numberOfReps: 5),
//                        secondExercise:  Exercise(name: ExerciseNames.squat, weight: 90.0, numberOfSets: 1, numberOfReps: 5),
//                        thirdExercise: Exercise(name: ExerciseNames.dumbbellCurl, weight: 45, numberOfSets: 3, numberOfReps: 12),
//                        initialWorkout: sut.initialPullWorkout())
//    }
//    
//    func testInitialPushWorkoutExercisesAndWorkoutType_ShouldBeEqual() {
//        performEqual(firstWorkoutType: .push,
//                     firstExercise:  Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 5, numberOfReps: 5),
//                     secondExercise: Exercise(name: ExerciseNames.overheadPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                     thirdExercise: Exercise(name: ExerciseNames.inclineDumbellPress, weight: 15, numberOfSets: 3, numberOfReps: 12),
//                     initialWorkout: sut.initialPushWorkout())
//    }
//    
//    func testInitialPushWorkoutWhenExercisesAndWorkoutTypeDiffer_ShouldBeNotEqual() {
//        performNotEqual(firstWorkoutType: .alternatePull,
//                        firstExercise: Exercise(name: ExerciseNames.lateralRaise, weight: 10.0, numberOfSets: 3, numberOfReps: 20),
//                        secondExercise: Exercise(name: ExerciseNames.seatedCableRow, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                        thirdExercise: Exercise(name: ExerciseNames.romanianDeadlift, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                        initialWorkout: sut.initialPushWorkout())
//    }
//    
//    func testInitialLegWorkoutExercisesAndWorkoutType_ShouldBeEqual() {
//        performEqual(firstWorkoutType: .legs,
//                     firstExercise: Exercise(name: ExerciseNames.squat, weight: 135.0, numberOfSets: 3, numberOfReps: 5),
//                     secondExercise: Exercise(name: ExerciseNames.romanianDeadlift, weight: 135.0, numberOfSets: 3, numberOfReps: 12),
//                     thirdExercise: Exercise(name: ExerciseNames.legPress, weight: 225, numberOfSets: 3, numberOfReps: 12),
//                     initialWorkout: sut.initialLegWorkout())
//    }
//    
//    func testInitialLegWorkoutWhenExercisesAndWorkoutTypeDiffer_ShouldBeNotEqual() {
//        performNotEqual(firstWorkoutType: .push,
//                        firstExercise: Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                        secondExercise: Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                        thirdExercise: Exercise(name: ExerciseNames.calfRaise, weight: 45.0, numberOfSets: 5, numberOfReps: 20),
//                        initialWorkout: sut.initialLegWorkout())
//    }
//    
//    func testInitialAlternatePullWorkoutExercisesAndWorkoutType_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        performEqual(firstWorkoutType: .alternatePull,
//                     firstExercise: Exercise(name: ExerciseNames.barbellRow, weight: 45.0, numberOfSets: 5, numberOfReps: 5),
//                     secondExercise: Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                     thirdExercise: Exercise(name: ExerciseNames.seatedCableRow, weight: 45, numberOfSets: 3, numberOfReps: 12),
//                     initialWorkout: sut.initialAlternatePullWorkout())
//    }
//    
//    func testInitialAlternatePushWorkout() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        performEqual(firstWorkoutType: .alternatePush,
//                     firstExercise: Exercise(name: ExerciseNames.overheadPress, weight: 50.0, numberOfSets: 5, numberOfReps: 5),
//                     secondExercise: Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12),
//                     thirdExercise: Exercise(name: ExerciseNames.inclineDumbellPress, weight: 15, numberOfSets: 3, numberOfReps: 12),
//                     initialWorkout: sut.initialAlternatePushWorkout())
//    }
//    
//    // MARK: Workout Manager Helper Method Tests
//    func testMostRecentWorkoutWhenPastExerciseCountIsZero_ShouldBeNil() {
//        let mostRecentPullWorkout = sut.mostRecentWorkout(ofType: .pull)
//        
//        XCTAssertNil(mostRecentPullWorkout)
//    }
//    
//    func testMostRecentPullWorkoutWithOriginalWorkout_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let mostRecentPullWorkout = sut.mostRecentWorkout(ofType: .pull)
//        
//        XCTAssertEqual(pullWorkout, mostRecentPullWorkout!)
//    }
//    
//    func testMostRecentPushWorkoutWithOriginalWorkout_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let mostRecentPushWorkout = sut.mostRecentWorkout(ofType: .push)
//        
//        XCTAssertEqual(pushWorkout, mostRecentPushWorkout!)
//    }
//    
//    func testMostRecentLegWorkoutWithOriginalWorkout_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//
//        let mostRecentLegWorkout = sut.mostRecentWorkout(ofType: .legs)
//        
//        XCTAssertEqual(legWorkout, mostRecentLegWorkout!)
//    }
//    
//    func testMostRecentAltPullWithOriginalWorkout_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let mostRecentAltPullWorkout = sut.mostRecentWorkout(ofType: .alternatePull)
//        
//        XCTAssertEqual(altPullWorkout, mostRecentAltPullWorkout!)
//    }
//    
//    func testMostRecentWorkoutOfSpecificTypeWhenWorkoutTypeIsNotInPastExercises_ShouldBeNil() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let mostRecentAlternatePullWorkout = sut.mostRecentWorkout(ofType: .alternatePull)
//        
//        XCTAssertNil(mostRecentAlternatePullWorkout)
//    }
//    
//    // MARK: Workout Creation Tests
//    func testLegWorkoutFromPastExercisesWithoutProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let newLegWorkout = sut.legWorkout()
//        
//        XCTAssertNotEqual(legWorkout, newLegWorkout)
//        XCTAssertEqual(legWorkout.exercises[0].weight, newLegWorkout.exercises[0].weight)
//    }
//    
//    func testLegWorkoutFromPastExercisesWithProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//    
//        let legWorkout = sut.initialLegWorkout()
//        let updatedLegWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: legWorkout)
//        sut.add(updatedLegWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let newLegWorkout = sut.legWorkout()
//        
//        XCTAssertNotEqual(legWorkout.date, newLegWorkout.date)
//        XCTAssertNotEqual(legWorkout.exercises, newLegWorkout.exercises)
//        XCTAssertEqual(newLegWorkout.exercises[0].weight, legWorkout.exercises[0].weight + 5.0)
//    }
//    
//    func testPullWorkoutFromPastExercisesWithoutProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        
//        let newPullWorkout = sut.pullWorkout()
//        
//        XCTAssertNotEqual(pullWorkout.date, newPullWorkout.date)
//        XCTAssertEqual(pullWorkout.exercises[0].weight, newPullWorkout.exercises[0].weight)
//    }
//
//    func testPullWorkoutFromPastExercisesWithProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        
//        let newPullWorkout = sut.pullWorkout()
//        
//        XCTAssertNotEqual(newPullWorkout.date, pullWorkout.date)
//        XCTAssertNotEqual(newPullWorkout.exercises, pullWorkout.exercises)
//        
//        XCTAssertEqual(newPullWorkout.exercises[0].name, pullWorkout.exercises[0].name)
//        XCTAssertEqual(newPullWorkout.exercises[0].weight, pullWorkout.exercises[0].weight + 10.0)
//        
//        XCTAssertEqual(newPullWorkout.exercises[1].name, altPullWorkout.exercises[1].name)
//        XCTAssertEqual(newPullWorkout.exercises[1].weight, altPullWorkout.exercises[1].weight + 2.5)
//    }
//
//    func testPushWorkoutFromPastExercisesWithoutProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let newPushWorkout = sut.pushWorkout()
//        
//        XCTAssertNotEqual(pushWorkout.date, newPushWorkout.date)
//        XCTAssertEqual(pushWorkout.exercises[0].weight, newPushWorkout.exercises[0].weight)
//    }
//
//    func testPushWorkoutFromPastExercisesWithProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        let updatedPushWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pushWorkout)
//        sut.add(updatedPushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        let updatedAltPushWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPushWorkout)
//        sut.add(updatedAltPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let newPushWorkout = sut.pushWorkout()
//        
//        XCTAssertNotEqual(newPushWorkout.date, pushWorkout.date)
//        XCTAssertNotEqual(newPushWorkout.exercises, pushWorkout.exercises)
//       
//        XCTAssertEqual(newPushWorkout.exercises[0].name, pushWorkout.exercises[0].name)
//        XCTAssertEqual(newPushWorkout.exercises[0].weight, pushWorkout.exercises[0].weight + 5.0)
//        
//        XCTAssertEqual(newPushWorkout.exercises[1].name, pushWorkout.exercises[1].name)
//        XCTAssertEqual(newPushWorkout.exercises[1].weight, pushWorkout.exercises[1].weight + 5.0)
//        
//        XCTAssertEqual(newPushWorkout.exercises[2].name, altPushWorkout.exercises[2].name)
//        XCTAssertEqual(newPushWorkout.exercises[2].weight, altPushWorkout.exercises[2].weight + 2.5)
//    }
//
//    func testAlternatePullWorkoutFromPastExercisesWithoutProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let newAltPullWorkout = sut.alternatePullWorkout()
//        
//        XCTAssertNotEqual(altPullWorkout.date, newAltPullWorkout.date)
//        XCTAssertEqual(altPullWorkout.exercises[0].weight, newAltPullWorkout.exercises[0].weight)
//    }
//
//    func testAlternatePullWorkoutFromPastExercisesWithProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        let updatedPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pullWorkout)
//        sut.add(updatedPullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        let updatedAltPullWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPullWorkout)
//        sut.add(updatedAltPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        let updatedPullWorkout2 = simulateWorkoutCompletion(withStatus: .completed, forExercise: pullWorkout2)
//        sut.add(updatedPullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let newAltPullWorkout = sut.alternatePullWorkout()
//        
//        XCTAssertNotEqual(newAltPullWorkout.date, altPullWorkout.date)
//        XCTAssertNotEqual(newAltPullWorkout.exercises, altPullWorkout.exercises)
//        
//        XCTAssertEqual(newAltPullWorkout.exercises[0].name, altPullWorkout.exercises[0].name)
//        XCTAssertEqual(newAltPullWorkout.exercises[0].weight, altPullWorkout.exercises[0].weight + 5.0)
//        
//        XCTAssertEqual(newAltPullWorkout.exercises[1].name, pullWorkout2.exercises[1].name)
//        XCTAssertEqual(newAltPullWorkout.exercises[1].weight, pullWorkout2.exercises[1].weight + 2.5)
//    }
//    
//    func testAlternatePushWorkoutFromPastExercisesWithoutProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let altPullWorkout2 = sut.alternatePullWorkout()
//        sut.add(altPullWorkout2)
//        
//        let newAltPushWorkout = sut.alternatePushWorkout()
//        
//        XCTAssertNotEqual(altPushWorkout.date, newAltPushWorkout.date)
//        XCTAssertEqual(altPushWorkout.exercises[0].weight, newAltPushWorkout.exercises[0].weight)
//    }
//
//    func testAlternatePushWorkoutFromPastExercisesWithProgress_ShouldBeEqual() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        let updatedPushWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: pushWorkout)
//        sut.add(updatedPushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        let updatedAltPushWorkout = simulateWorkoutCompletion(withStatus: .completed, forExercise: altPushWorkout)
//        sut.add(updatedAltPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        let updatedPushWorkout2 = simulateWorkoutCompletion(withStatus: .completed, forExercise: pushWorkout2)
//        sut.add(updatedPushWorkout2)
//        
//        let altPullWorkout2 = sut.alternatePullWorkout()
//        sut.add(altPullWorkout2)
//        
//        let newAltPushWorkout = sut.alternatePushWorkout()
//        
//        XCTAssertNotEqual(newAltPushWorkout.date, altPushWorkout.date)
//        XCTAssertNotEqual(newAltPushWorkout.exercises, altPushWorkout.exercises)
//        
//        XCTAssertEqual(newAltPushWorkout.exercises[0].name, altPushWorkout.exercises[0].name)
//        XCTAssertEqual(newAltPushWorkout.exercises[0].weight, altPushWorkout.exercises[0].weight + 5.0)
//        
//        XCTAssertEqual(newAltPushWorkout.exercises[1].name, altPushWorkout.exercises[1].name)
//        XCTAssertEqual(newAltPushWorkout.exercises[1].weight, altPushWorkout.exercises[1].weight + 5.0)
//        
//        XCTAssertEqual(newAltPushWorkout.exercises[2].name, pushWorkout2.exercises[2].name)
//        XCTAssertEqual(newAltPushWorkout.exercises[2].weight, pushWorkout2.exercises[2].weight + 2.5)
//    }
//    
//    // MARK: Automatically Generated Current Workout Tests
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnPullWorkout() {
//        simulateFirstWeekOfWorkouts()
//        
//        let nextWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(nextWorkout.type, .pull)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnPushWorkout() {
//        simulateFirstWeekOfWorkouts()
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let nextWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(nextWorkout.type, .push)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnLegWorkoutAfterAltWorkouts() {
//        simulateFirstWeekOfWorkouts()
//        
//        sut.removeWorkout(atIndex: 0)
//        
//        let nextWorkout = sut.createWorkout()
//        
//        XCTAssertEqual(nextWorkout.type, .legs)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnAltPullWorkout() {
//        simulateFirstWeekOfWorkouts()
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let legWorkout3 = sut.legWorkout()
//        sut.add(legWorkout3)
//        
//        let nextWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(nextWorkout.type, .alternatePull)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnAltPushWorkout() {
//        simulateFirstWeekOfWorkouts()
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let legWorkout3 = sut.legWorkout()
//        sut.add(legWorkout3)
//        
//        let altPullWorkout2 = sut.alternatePullWorkout()
//        sut.add(altPullWorkout2)
//        
//        let nextWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(nextWorkout.type, .alternatePush)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//    func testCurrentWorkoutBasedOnPastExercises_ShouldReturnLegWorkoutAfterRegularWorkouts() {
//        simulateFirstWeekOfWorkouts()
//        
//        let pullWorkout2 = sut.pullWorkout()
//        sut.add(pullWorkout2)
//        
//        let pushWorkout2 = sut.pushWorkout()
//        sut.add(pushWorkout2)
//        
//        let legWorkout3 = sut.legWorkout()
//        sut.add(legWorkout3)
//        
//        let altPullWorkout2 = sut.alternatePullWorkout()
//        sut.add(altPullWorkout2)
//        
//        let altPushWorkout2 = sut.alternatePushWorkout()
//        sut.add(altPushWorkout2)
//        
//        let nextWorkout = sut.currentWorkout!
//        
//        XCTAssertEqual(nextWorkout.type, .legs)
//        XCTAssertNotNil(nextWorkout.exercises)
//    }
//    
//}
//
//extension WorkoutManagerTests {
//    func performEqual(firstWorkoutType: WorkoutType, firstExercise: Exercise, secondExercise: Exercise, thirdExercise: Exercise, initialWorkout: Workout, line: UInt = #line) {
//        XCTAssertEqual(initialWorkout.exercises[0].weight, firstExercise.weight)
//        XCTAssertEqual(initialWorkout.exercises[1].weight, secondExercise.weight)
//        XCTAssertEqual(initialWorkout.exercises[2].weight, thirdExercise.weight)
//        XCTAssertEqual(initialWorkout.type, firstWorkoutType)
//    }
//    
//    func performNotEqual(firstWorkoutType: WorkoutType, firstExercise: Exercise, secondExercise: Exercise, thirdExercise: Exercise, initialWorkout: Workout, line: UInt = #line) {
//        XCTAssertNotEqual(initialWorkout.exercises[0], firstExercise)
//        XCTAssertNotEqual(initialWorkout.exercises[1], secondExercise)
//        XCTAssertNotEqual(initialWorkout.exercises[2], thirdExercise)
//        XCTAssertNotEqual(initialWorkout.type, firstWorkoutType)
//    }
//
//    enum SetStatus {
//        case completed
//        case incomplete
//    }
//    
//    func simulateSetCompletion(withStatus status: SetStatus, forExercise exercise: Exercise) -> [ExerciseSet] {
//        let numberOfRepsCompleted: Int
//        var updatedSet = [ExerciseSet]()
//        
//        switch status {
//        case .completed:
//            numberOfRepsCompleted = exercise.sets.first!.numberOfReps
//        case .incomplete:
//            numberOfRepsCompleted = Int(arc4random_uniform(UInt32(exercise.sets.first!.numberOfReps)))
//        }
//        
//        for i in 0..<exercise.sets.count {
//            let set = (exercise |> Exercise.setsLens.get)[i] |> ExerciseSet.numberOfRepsCompletedLens *~ numberOfRepsCompleted
//            updatedSet.append(set)
//        }
//        
//        return updatedSet
//    }
//    
//    func simulateWorkoutCompletion(withStatus status: SetStatus, forExercise workout: Workout) -> Workout {
//        var updatedExercises = [Exercise]()
//        
//        for exercise in workout.exercises {
//            let updatedSets = simulateSetCompletion(withStatus: status, forExercise: exercise)
//            let updatedExercise = exercise |> Exercise.setsLens *~ updatedSets
//            updatedExercises.append(updatedExercise)
//        }
//        
//        return workout |> Workout.exercisesLens *~ updatedExercises
//        
//    }
//    
//    func simulateFirstWeekOfWorkouts() {
//        let pullWorkout = sut.initialPullWorkout()
//        sut.add(pullWorkout)
//        
//        let pushWorkout = sut.initialPushWorkout()
//        sut.add(pushWorkout)
//        
//        let legWorkout = sut.initialLegWorkout()
//        sut.add(legWorkout)
//        
//        let altPullWorkout = sut.initialAlternatePullWorkout()
//        sut.add(altPullWorkout)
//        
//        let altPushWorkout = sut.initialAlternatePushWorkout()
//        sut.add(altPushWorkout)
//        
//        let legWorkout2 = sut.legWorkout()
//        sut.add(legWorkout2)
//    }
//    
//    
//}
