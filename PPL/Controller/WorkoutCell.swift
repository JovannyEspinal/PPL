//
//  WorkoutCell.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var exerciseOneLabel: UILabel!
    @IBOutlet weak var exerciseTwoLabel: UILabel!

    func configCell(with workout: Workout) {
        self.typeLabel.text = workout.type.rawValue.uppercased()
        self.dateLabel.text = workout.date.stringDate().uppercased()
        
        let firstExercise = workout.exercises[0]
        let secondExercise = workout.exercises[1]
        
        self.exerciseOneLabel.text = firstExercise.description
        self.exerciseTwoLabel.text = secondExercise.description
    }
}
