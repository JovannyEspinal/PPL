//
//  WorkoutCellTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/25/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class WorkoutCellTests: XCTestCase {
    var tableView: UITableView!
    let dataProvider = FakeDataSource()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WorkoutListViewController") as! WorkoutListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = dataProvider
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_ShouldHaveTypeLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: IndexPath(row: 0, section: 0)) as! WorkoutCell
        
        XCTAssertNotNil(cell.typeLabel)
    }
    
    func testSUT_ShouldHaveDateLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: IndexPath(row: 0, section: 0)) as! WorkoutCell
        
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testSUT_ShouldHaveExerciseOneLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: IndexPath(row: 0, section: 0)) as! WorkoutCell
        
        XCTAssertNotNil(cell.exerciseOneLabel)
    }
    
    func testSUT_ShouldHaveExerciseTwoLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: IndexPath(row: 0, section: 0)) as! WorkoutCell
        
        XCTAssertNotNil(cell.exerciseTwoLabel)
    }
    
    func testConfigWithWorkout_SetsLabelText() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: IndexPath(row: 0, section: 0)) as! WorkoutCell
        
        let dateString = "OCT 26"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        let date = dateFormatter.date(from: dateString)
        
        let wm = WorkoutManager.manager
        let currentWorkout = wm.createWorkout() |> Workout.dateLens *~ date!
        
        cell.configCell(with: currentWorkout)
        
        XCTAssertEqual(cell.typeLabel.text, "PULL")
        XCTAssertEqual(cell.dateLabel.text, dateString)
        XCTAssertEqual(cell.exerciseOneLabel.text, "Deadlift 1x5 90lbs")
        XCTAssertEqual(cell.exerciseTwoLabel.text, "Lat Pulldown 3x12 45lbs")
    }
    
    
}

extension WorkoutCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
