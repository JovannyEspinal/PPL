////
////  WorkoutListDataProviderTests.swift
////  PPL
////
////  Created by Jovanny Espinal on 10/21/16.
////  Copyright © 2016 Jovanny Espinal. All rights reserved.
////
//
//import XCTest
//@testable import PPL
//
//class WorkoutListDataProviderTests: XCTestCase {
//    var sut: WorkoutListDataProvider!
//    var controller: WorkoutListViewController!
//    var tableView: UITableView!
//    
//    override func setUp() {
//        super.setUp()
//        sut = WorkoutListDataProvider()
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        controller = storyboard.instantiateViewController(withIdentifier: "WorkoutListViewController") as! WorkoutListViewController
//        
//        _ = controller.view
//        
//        tableView = controller.tableView
//        tableView.dataSource = sut
//        tableView.delegate = sut
//        
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//        sut.workoutManager.removeAllWorkouts()
//    }
//    
//    func testCurrentWorkout_ShouldBeNotNil() {
//        XCTAssertNotNil(sut.workoutManager.currentWorkout)
//    }
//    
//    func testNumberOfSections_isTwo() {
//        let numberOfSections = tableView.numberOfSections
//        
//        XCTAssertEqual(numberOfSections, 2)
//    }
//    
//    func testNumberOfRowsInFirstSection_ShouldBeOne() {
//        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
//    }
//    
//    func testNumberOfRowsInSecondSection_ShouldBeTwo() {
//        let pullWorkout = sut.workoutManager.createWorkout()
//        sut.workoutManager.add(pullWorkout)
//        
//        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
//        
//        
//        let pushWorkout = sut.workoutManager.currentWorkout!
//        sut.workoutManager.add(pushWorkout)
//        tableView.reloadData()
//        
//        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
//    }
//    
//    func testCellFor_ReturnsWorkoutCell() {
//        let pullWorkout = sut.workoutManager.createWorkout()
//        sut.workoutManager.add(pullWorkout)
//        
//        tableView.reloadData()
//        
//        let currentWorkoutCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
//        let pastWorkoutCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
//        
//        XCTAssertTrue(currentWorkoutCell is WorkoutCell)
//        XCTAssertTrue(pastWorkoutCell is WorkoutCell)
//        
//    }
//    
//    func testCellForRow_DequeuesCell() {
//        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
//        
//        let pullWorkout = sut.workoutManager.currentWorkout
//        sut.workoutManager.add(pullWorkout!)
//        
//        XCTAssertEqual(sut.workoutManager.pastWorkoutsCount, 1)
//        mockTableView.reloadData()
//        
//        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
//        
//        XCTAssertTrue(mockTableView.cellGotDequeued)
//        
//    }
//    
//    func testConfigCell_GetsCalledInCellForRow() {
//        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
//        mockTableView.reloadData()
//        
//        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockWorkoutCell
//        
//        XCTAssertEqual(cell.workout, sut.workoutManager.currentWorkout)
//    }
//    
//    func testCellInSectionTwo_GetsConfiguredWithPastWorkout() {
//        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
//        
//        let completedWorkout = sut.workoutManager.currentWorkout
//        sut.workoutManager.add(completedWorkout!)
//        
//        mockTableView.reloadData()
//        
//        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockWorkoutCell
//        
//        XCTAssertEqual(cell.workout, completedWorkout)
//    }
//    
//    func testHeaderInSectionOne_ShouldBeNextSession() {
//        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
//        
//        let header = mockTableView.dataSource?.tableView!(mockTableView, titleForHeaderInSection: 0)
//        
//        XCTAssertEqual(header, "Next Session")
//    }
//    
//    func testHeaderInSectionTwo_ShouldBePastSessions() {
//        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
//        
//        let completedWorkout = sut.workoutManager.currentWorkout
//        sut.workoutManager.add(completedWorkout!)
//        
//        mockTableView.reloadData()
//        
//        let header = mockTableView.dataSource?.tableView!(mockTableView, titleForHeaderInSection: 1)
//        
//        XCTAssertEqual(header, "Past Sessions")
//    }
//    
//}
//
//extension WorkoutListDataProviderTests {
//    class MockTableView: UITableView {
//        var cellGotDequeued = false
//        
//        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
//            cellGotDequeued = true
//            
//            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        }
//        
//        class func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView {
//            let mockTableView = MockTableView(
//                frame: CGRect(x: 0, y: 0, width: 320, height: 480),
//                style: .grouped)
//            
//            mockTableView.dataSource = dataSource
//            
//            mockTableView.register(MockWorkoutCell.self, forCellReuseIdentifier: "WorkoutCell")
//            
//            return mockTableView
//        }
//    }
//    
//    class MockWorkoutCell: WorkoutCell {
//        var workout: Workout?
//        
//        override func configCell(with workout: Workout) {
//            self.workout = workout
//        }
//    }
//}
//
