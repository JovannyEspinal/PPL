//
//  WorkoutListDataProvider.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    let workoutManager = WorkoutManager.manager
    
    enum Section: Int {
        case nextSession
        case pastSessions
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sessionSection = Section(rawValue: section) else { fatalError() }
        
        let numberOfRows: Int
        
        switch sessionSection {
        case .nextSession:
            numberOfRows = 1
        case .pastSessions:
            numberOfRows = workoutManager.pastWorkoutsCount
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        
        guard let currentWorkout = WorkoutManager.manager.currentWorkout else { fatalError() }
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        let workout: Workout
        
        switch section {
        case .nextSession:
            workout = currentWorkout
            cell.dateLabel.isHidden = true
        case .pastSessions:
            workout = workoutManager.workout(atIndex: indexPath.row)!
        }
        
        cell.configCell(with: workout)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let headerTitle: String
        
        guard let section = Section(rawValue: section) else { fatalError() }
        
        switch section {
        case .nextSession:
            headerTitle = "Next Session"
        case .pastSessions:
            headerTitle = "Past Sessions"
        }
        
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            NotificationCenter.default.post(name: Notification.Name("CurrentSessionTapped"), object: nil)
        } else {
            let workoutDate = workoutManager.workout(atIndex: indexPath.row)?.date.stringDate() ?? "N/A"
            NotificationCenter.default.post(name: Notification.Name("PastSessionTapped"), object: nil, userInfo: ["index": indexPath.row, "date": workoutDate])
        }
    }
}
