//
//  LoggingWorkoutDataProvider.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/26/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class LoggingWorkoutDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    let workoutManager = WorkoutManager.manager

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workoutManager.currentWorkout?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        guard let _ = workoutManager.currentWorkout?.exercises[indexPath.row] else { return UITableViewCell() }
        
        cell.index = indexPath.row
        cell.config()
        
        return cell
    }
    
}
