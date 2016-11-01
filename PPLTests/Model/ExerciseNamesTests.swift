//
//  ExerciseNamesTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL
class ExerciseNamesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPullExerciseNames() {
        let deadlift = "Deadlift"
        let barbellRow = "Barbell Row"
        let pulldown = "Lat Pulldown"
        let pullup = "Pullup"
        let chinup = "Chinup"
        let seatedCableRow = "Seated Cable Row"
        let facePull = "Face Pull"
        let hammerCurl = "Hammer Curl"
        let dumbbellCurl = "Dumbbell Curl"
        
        XCTAssertEqual(ExerciseNames.deadlift, deadlift)
        XCTAssertEqual(ExerciseNames.barbellRow, barbellRow)
        XCTAssertEqual(ExerciseNames.pulldown, pulldown)
        XCTAssertEqual(ExerciseNames.pullup, pullup)
        XCTAssertEqual(ExerciseNames.chinup, chinup)
        XCTAssertEqual(ExerciseNames.seatedCableRow, seatedCableRow)
        XCTAssertEqual(ExerciseNames.facePull, facePull)
        XCTAssertEqual(ExerciseNames.hammerCurl, hammerCurl)
        XCTAssertEqual(ExerciseNames.dumbbellCurl, dumbbellCurl)
        
    }
    
    func testPushExerciseNames() {
        let benchPress = "Bench Press"
        let overheadPress = "Overhead Press"
        let inclineDumbellPress = "Incline Dumbbell Press"
        let tricepsPushdown = "Triceps Pushdown"
        let overheadTricepsExtension = "Overhead Triceps Extension"
        let lateralRaise = "Lateral Raise"
        
        XCTAssertEqual(ExerciseNames.benchPress, benchPress)
        XCTAssertEqual(ExerciseNames.overheadPress, overheadPress)
        XCTAssertEqual(ExerciseNames.inclineDumbellPress, inclineDumbellPress)
        XCTAssertEqual(ExerciseNames.tricepsPushdown, tricepsPushdown)
        XCTAssertEqual(ExerciseNames.overheadTricepsExtension, overheadTricepsExtension)
        XCTAssertEqual(ExerciseNames.lateralRaise, lateralRaise)
    }
    
    func testLegExerciseNames() {
        let squat = "Squat"
        let romanianDeadlift = "Romanian Deadlift"
        let legPress = "Leg Press"
        let legCurl = "Leg Curl"
        let calfRaise = "Calf Raise"
        
        XCTAssertEqual(ExerciseNames.squat, squat)
        XCTAssertEqual(ExerciseNames.romanianDeadlift, romanianDeadlift)
        XCTAssertEqual(ExerciseNames.legPress, legPress)
        XCTAssertEqual(ExerciseNames.legCurl, legCurl)
        XCTAssertEqual(ExerciseNames.calfRaise, calfRaise)
    }
    
}
