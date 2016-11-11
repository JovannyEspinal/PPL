//
//  LoggingWorkoutDataProvider.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/26/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class LoggingWorkoutDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    let currentWorkout = WorkoutManager.manager.currentWorkout!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentWorkout.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        cell.index = indexPath.row
        cell.config()
        
        return cell
    }
}
