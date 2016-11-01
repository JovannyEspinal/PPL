//
//  WeightChangeViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/28/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

protocol WeightChangedViewControllerDelegate {
    func weightChanged(exerciseIndex: Int, weight: Double)
}

class WeightChangeViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var delegate: WeightChangedViewControllerDelegate?
    var index: Int! {
        didSet {
            weight = WorkoutManager.manager.currentWorkout?.exercises[index].weight
        }
    }
    var weight: Double?
    let barbellExercises = [ExerciseNames.deadlift, ExerciseNames.barbellRow, ExerciseNames.benchPress, ExerciseNames.overheadPress, ExerciseNames.romanianDeadlift, ExerciseNames.legPress, ExerciseNames.squat]
    let compoundExercises = [ExerciseNames.deadlift, ExerciseNames.barbellRow, ExerciseNames.benchPress, ExerciseNames.overheadPress, ExerciseNames.squat]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
    }
    
    
    @IBAction func incrementWeight() {
        
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, let updatedWeight = weight {
            weight = compoundExercises.contains(exerciseName) ? updatedWeight + 5.0 : updatedWeight + 2.5
        }
        
        updateLabel()
    }
    
    @IBAction func decrementWeight() {
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, let updatedWeight = weight {
            
            if updatedWeight == 0 {
                return
            }
            
            weight = compoundExercises.contains(exerciseName) ? updatedWeight - 5.0 : updatedWeight - 2.5
        }
        
        updateLabel()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        
        if let exercise = WorkoutManager.manager.currentWorkout?.exercises[index], let updatedWeight = weight {
            let updatedExercise = exercise |> Exercise.weightLens *~ updatedWeight
            
           WorkoutManager.manager.currentWorkout?.exercises[index] = updatedExercise
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func updateLabel() {
        guard let updatedWeight = weight else { return }
        
        weightLabel.text = "\(updatedWeight)"
        
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, barbellExercises.contains(exerciseName) {
            
            navigationBar.topItem?.title = updatedWeight <= 45.0 ? "Lift The Empty Bar" : "Add \((updatedWeight-45.0)/2)lbs/side"
        } else {
            navigationBar.topItem?.title = "Change Exercise Weight"
        }
    }
}
