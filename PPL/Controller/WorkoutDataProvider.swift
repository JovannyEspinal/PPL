//
//  WorkoutDataProvider.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/4/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import Foundation

class WorkoutDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var index: Int? {
        didSet {
            if let index = index {
                exercises = WorkoutManager.manager.pastWorkouts[index].exercises
            }
        }
    }
    
    var exercises: [Exercise]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ = index else { return 0 }
        
        return exercises!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastExerciseCell", for: indexPath) as! PastWorkoutCell
        
        guard let exercise = exercises?[indexPath.row] else { return UITableViewCell() }
        
        cell.config(with: exercise)
        
        return cell
    }
}
