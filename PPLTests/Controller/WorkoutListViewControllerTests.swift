////
////  WorkoutListViewControllerTests.swift
////  PPL
////
////  Created by Jovanny Espinal on 10/21/16.
////  Copyright © 2016 Jovanny Espinal. All rights reserved.
////
//
//import XCTest
//@testable import PPL
//
//class WorkoutListViewControllerTests: XCTestCase {
//    var sut: WorkoutListViewController!
//    
//    override func setUp() {
//        super.setUp()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let dataProvider = WorkoutListDataProvider()
//        sut = storyboard.instantiateViewController(withIdentifier: "WorkoutListViewController") as! WorkoutListViewController
//        sut.dataProvider = dataProvider
//        
//        _ = sut.view
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//    
//    func test_TableViewIsNotNilAfterViewDidLoad() {
//        XCTAssertNotNil(sut.tableView)
//    }
//    
//    func testViewDidLoad_ShouldSetTableViewDataSource() {
//       
//        XCTAssertNotNil(sut.tableView.dataSource)
//        XCTAssertTrue(sut.tableView.dataSource is WorkoutListDataProvider)
//    }
//    
//    func testViewDidLoad_ShouldSetTableViewDelegate() {
//        XCTAssertNotNil(sut.tableView.delegate)
//        XCTAssertTrue(sut.tableView.delegate is WorkoutListDataProvider)
//    }
//    
//    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
//        XCTAssertEqual(sut.tableView.delegate as? WorkoutListDataProvider, sut.tableView.dataSource as? WorkoutListDataProvider)
//    }
//    
//    
//    func testWorkoutListViewController_HasAddBarButtonItemWithSelfAsTarget() {
//        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
//        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController, sut)
//    }
//    
//    func testViewControllerTitle() {
//        XCTAssertEqual(sut.title, "PPL")
//    }
//    
//    func testAddWorkout_PresentsLoggingViewController() {
//        let navigationController = MockNavigationController(rootViewController: sut)
//        
//        UIApplication.shared.keyWindow?.rootViewController = navigationController
//
//        guard let addButton = sut.navigationItem.rightBarButtonItem else {
//            XCTFail()
//            return
//        }
//        
//        sut.perform(addButton.action, with: addButton)
//        
//        let loggingVC = navigationController.pushedViewController
//        
//        XCTAssertTrue(loggingVC is LoggingViewController)
//    }
//    
//    func testCurrentSessionSelectedNotification_PushesLoggingViewController() {
//        let navigationController = MockNavigationController(rootViewController: sut)
//        
//        UIApplication.shared.keyWindow?.rootViewController = navigationController
//        
//        _ = sut.view
//        
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "CurrentSessionTapped"), object: nil)
//        
//        let loggingVC = navigationController.pushedViewController
//        
//        XCTAssertTrue(loggingVC is LoggingViewController)
//    }
//    
//    func testWorkoutListViewController_SharesWorkoutWithLoggingViewController() {
//        let navigationController = MockNavigationController(rootViewController: sut)
//        UIApplication.shared.keyWindow?.rootViewController = navigationController
//        
//        guard let addButton = sut.navigationItem.rightBarButtonItem else {
//            XCTFail()
//            return
//        }
//        
//        sut.perform(addButton.action, with: addButton)
//
//        XCTAssertTrue(navigationController.pushedViewController is LoggingViewController)
//        
//        let loggingViewController = navigationController.pushedViewController as! LoggingViewController
//
//        
//        XCTAssertTrue(sut.dataProvider.workoutManager === loggingViewController.dataProvider.workoutManager)
//    }
//}
//
//extension WorkoutListViewControllerTests {
//    class MockNavigationController: UINavigationController {
//        
//        var pushedViewController: UIViewController?
//        
//        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//            pushedViewController = viewController
//            super.pushViewController(viewController, animated: true)
//        }
//    }
//}
