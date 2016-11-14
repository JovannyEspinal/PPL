//
//  LoggingWorkoutDataProviderTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/27/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class LoggingWorkoutDataProviderTests: XCTestCase {
    var sut: LoggingWorkoutDataProvider!
    var controller: LoggingViewController!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        sut = LoggingWorkoutDataProvider()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        controller = storyboard.instantiateViewController(withIdentifier: "LoggingViewController") as! LoggingViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCurrentWorkout_ShouldBeNotNil() {
        XCTAssertNotNil(sut.currentWorkout)
    }
    
    func testNumberOfSections_isOne() {
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfRowsInFirstSection_ShouldBeNumberOfExercises() {
        
        let numberOfExercises = sut.currentWorkout.exercises.count
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), numberOfExercises)
    }
    
    func testCell_ReturnsExercise() {
        tableView.reloadData()
        let exerciseCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(exerciseCell is ExerciseCell)
    }
    
    func testCellForRow_DequeuesCell() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
}

extension LoggingWorkoutDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(
                frame: CGRect(x: 0, y: 0, width: 320, height: 480),
                style: .grouped)
            
            mockTableView.dataSource = dataSource
            
            mockTableView.register(MockWorkoutCell.self, forCellReuseIdentifier: "ExerciseCell")
            
            return mockTableView
        }
    }
    
    class MockWorkoutCell: ExerciseCell {

        override func config() {
        }
    }
    
}
