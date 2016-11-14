//
//  PastWorkoutCellTableViewCell.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/4/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class PastWorkoutCell: UITableViewCell {
    @IBOutlet weak var setxWeightButton: UIButton!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet var sets: [RoundButton]!
    var exercise: Exercise? {
        didSet {
            setCount = exercise!.sets.count
        }
    }
    
    var setCount: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetForReuse()
    }
    
    func config(with exercise: Exercise) {
        self.exercise = exercise
        
        self.exerciseNameLabel.text = exercise.name
        
        setxWeightButton.setTitle(exercise.setxWeightDescription, for: .normal)
        
        if let setCount = setCount {
            for i in 0..<5-setCount {
                sets[5-i-1].disable()
            }
            
            for i in 0..<setCount {
                sets[i].format(with: exercise.sets[i])
            }
        }
    }
}

extension PastWorkoutCell {
    func resetForReuse() {
        if let setCount = setCount {
            for i in 0..<5-setCount {
                sets[5-i-1].enable()
            }
        }
    }
}
