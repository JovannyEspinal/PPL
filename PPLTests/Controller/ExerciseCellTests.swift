//
//  ExerciseCellTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/27/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class ExerciseCellTests: XCTestCase {
    var tableView: UITableView!
    let dataProvider = FakeDataSource()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoggingViewController") as! LoggingViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = dataProvider
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSUT_shouldHaveExerciseNameLabel() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: IndexPath(row: 0, section: 0)) as! ExerciseCell
        
        XCTAssertNotNil(cell.nameLabel)
    }
    
    func testSUT_ShouldHaveSetxWeightButton() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: IndexPath(row: 0, section: 0)) as! ExerciseCell
        
        XCTAssertNotNil(cell.setxWeightButton)
    }
    
}

extension ExerciseCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
