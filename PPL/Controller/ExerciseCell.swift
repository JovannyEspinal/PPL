//
//  ExerciseCell.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/27/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import UserNotifications

protocol ExerciseCellDelegate {
    func setLogged(set: (set: ExerciseSet, index: Int), exerciseIndex: Int)
}

class ExerciseCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setxWeightButton: UIButton!
    @IBOutlet var sets: [RoundButton]!
    var delegate: ExerciseCellDelegate?
    var index: Int! {
        didSet {
            setCount = WorkoutManager.manager.currentWorkout?.exercises[index].sets.count
        }
    }
    var setCount: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetForReuse()
    }
    
    func config() {
        self.nameLabel.text = WorkoutManager.manager.currentWorkout?.exercises[index].name
        
        setxWeightButton.setTitle(WorkoutManager.manager.currentWorkout?.exercises[index].setxWeightDescription, for: .normal)
        
        if let setCount = setCount, let exerciseSets = WorkoutManager.manager.currentWorkout?.exercises[index].sets {
            
            for i in 0..<5-setCount {
                sets[5-i-1].disable()
            }
            
            for i in 0..<setCount {
                sets[i].format(with: exerciseSets[i])
            }
        }
    }
    
    
    @IBAction func saveWorkout(_ sender: UIButton) {
        WorkoutManager.manager.add(WorkoutManager.manager.currentWorkout!)
    }
    
    @IBAction func changeWeight(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("ChangeWeightButtonTapped"), object: self, userInfo: ["index": index])
    }
    
    @IBAction func setButtonTapped(_ sender: RoundButton) {
        guard var set = WorkoutManager.manager.currentWorkout?.exercises[index].sets[sender.tag] else { return }
        
        if set.numberOfRepsCompleted == 0 && set.firstAttempt {
            let updatedSet = set |> ExerciseSet.numberOfRepsCompletedLens *~ set.numberOfReps
            
            set = updatedSet
            
            sender.ongoingButtonState(with: set)
        } else {
            let updatedSet = set |> ExerciseSet.numberOfRepsCompletedLens *~ (set.numberOfRepsCompleted - 1)
            set = updatedSet
            
            if set.numberOfRepsCompleted < 0 {
                let updatedSet = (set |> ExerciseSet.numberOfRepsCompletedLens *~ 0) |> ExerciseSet.firstAttemptLens *~ true
                
                set = updatedSet
                
                sender.initialButtonState()
            } else {
                sender.ongoingButtonState(with: set)
                
                let updatedSet = set |> ExerciseSet.firstAttemptLens *~ false
                
                set = updatedSet
            }
        }
        
        print(set.numberOfRepsCompleted)
        
        WorkoutManager.manager.currentWorkout?.exercises[index].sets[sender.tag] = set
        
        NotificationCenter.default.post(name: Notification.Name("SetButtonTapped"), object: self, userInfo: ["index": index, "numberOfRepsCompleted": set.numberOfRepsCompleted, "set": set])
    }
}

extension ExerciseCell {
    func resetForReuse() {
        if let setCount = setCount {
            for i in 0..<5-setCount {
                sets[5-i-1].enable()
            }
        }
    }
}
