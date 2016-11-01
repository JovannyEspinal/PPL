//
//  LoggingViewControllerTests.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/26/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import XCTest
@testable import PPL

class LoggingViewControllerTests: XCTestCase {
    var sut: LoggingViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "LoggingViewController") as! LoggingViewController
        
        _ = sut.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is LoggingWorkoutDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is LoggingWorkoutDataProvider)
    }
}

extension LoggingViewControllerTests {
    class MockTableView: UITableView {
        var dataHasReloaded = false
        
        override func reloadData() {
            dataHasReloaded = true
        }
    }
}
