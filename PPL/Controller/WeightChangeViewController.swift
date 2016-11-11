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
    @IBOutlet weak var fortyFivePlateLabel: UILabel!
    @IBOutlet weak var thirtyFivePlateLabel: UILabel!
    @IBOutlet weak var twentyFivePlateLabel: UILabel!
    @IBOutlet weak var tenPlateLabel: UILabel!
    @IBOutlet weak var fivePlateLabel: UILabel!
    @IBOutlet weak var twoAndAHalfPlateLabel: UILabel!
    @IBOutlet weak var addOnEachSideLabel: UILabel!
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
        
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, barbellExercises.contains(exerciseName) {
            addOnEachSideLabel.isHidden = false
            calculatePlates()
        } else {
            addOnEachSideLabel.isHidden = true
            fortyFivePlateLabel.isHidden = true
            thirtyFivePlateLabel.isHidden = true
            twentyFivePlateLabel.isHidden = true
            tenPlateLabel.isHidden = true
            fivePlateLabel.isHidden = true
            twoAndAHalfPlateLabel.isHidden = true
        }
    }
    
    @IBAction func incrementWeight() {
        
        guard let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, let updatedWeight = weight else { return }
        
        weight = compoundExercises.contains(exerciseName) ? updatedWeight + 5.0 : updatedWeight + 2.5
        
        updateLabel()
    }
    
    @IBAction func decrementWeight() {
        guard let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, let updatedWeight = weight else { return }
        
        if updatedWeight == 0 { return }
        
        weight = compoundExercises.contains(exerciseName) ? updatedWeight - 5.0 : updatedWeight - 2.5
        
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
        
        guard let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name else { return }
        
        let barbell: Double
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            let kgWeight = round((10.0*(updatedWeight.kilograms))) / 10.0
            
            weightLabel.text = "\(kgWeight)"
            barbell = 20
            
            if barbellExercises.contains(exerciseName) {
                navigationBar.topItem?.title = kgWeight <= barbell ? "Lift The Empty Bar" : "Add \((kgWeight-barbell)/2)kg/side"
            } else {
                navigationBar.topItem?.title = "Change Exercise Weight"
            }
            
            addOnEachSideLabel.text = "Add on each side of \(barbell)kg barbell"
        } else {
            weightLabel.text = "\(updatedWeight)"
            barbell = 45.0
            
            if barbellExercises.contains(exerciseName) {
                navigationBar.topItem?.title = updatedWeight <= barbell ? "Lift The Empty Bar" : "Add \((updatedWeight-barbell)/2)lbs/side"
            } else {
                navigationBar.topItem?.title = "Change Exercise Weight"
            }
            
            addOnEachSideLabel.text = "Add on each side of \(barbell)lb barbell"
        }
        
        calculatePlates()
    }
    
    func calculatePlates() {
        updatePlateLabels(with: PlateCalculator.plates(from: weight!))
    }
    
    func updatePlateLabels(with plates: [Double: Int]) {
        let plate2string: String
        let plate5string: String
        let plate10string: String
        let plate25string: String
        let plate35string: String
        let plate45string: String
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            plate2string = "1.25kg"
            plate5string = "2.5kg"
            plate10string = "5kg"
            plate25string = "11.25kg"
            plate35string = "16.5kg"
            plate45string = "20kg"
        } else {
            plate2string = "2.5lb"
            plate5string = "5lb"
            plate10string = "10lb"
            plate25string = "25lb"
            plate35string = "35lb"
            plate45string = "45lb"
        }
        
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, barbellExercises.contains(exerciseName) {
            if let fortyFivePlateCount = plates[45.0] {
                if fortyFivePlateCount == 0 {
                    fortyFivePlateLabel.isHidden = true
                } else {
                    fortyFivePlateLabel.text = "\(fortyFivePlateCount) x \(plate45string)"
                    fortyFivePlateLabel.isHidden = false
                }
            }
            
            if let thirtyFivePlateCount = plates[35.0] {
                if thirtyFivePlateCount == 0 {
                    thirtyFivePlateLabel.isHidden = true
                } else {
                    thirtyFivePlateLabel.text = "\(thirtyFivePlateCount) x \(plate35string)"
                    thirtyFivePlateLabel.isHidden = false
                }
            }
            
            if let twentyFivePlateCount = plates[25.0] {
                if twentyFivePlateCount == 0 {
                    twentyFivePlateLabel.isHidden = true
                } else {
                    twentyFivePlateLabel.text = "\(twentyFivePlateCount) x \(plate25string)"
                    twentyFivePlateLabel.isHidden = false
                }
            }
            
            if let tenPlateCount = plates[10.0] {
                if tenPlateCount == 0 {
                    tenPlateLabel.isHidden = true
                } else {
                    tenPlateLabel.text = "\(tenPlateCount) x \(plate10string)"
                    tenPlateLabel.isHidden = false
                }
            }
            
            if let fivePlateCount = plates[5.0] {
                if fivePlateCount == 0 {
                    fivePlateLabel.isHidden = true
                } else {
                    fivePlateLabel.text = "\(fivePlateCount) x \(plate5string)"
                    fivePlateLabel.isHidden = false
                }
            }
            
            if let twoAndAHalfPlateCount = plates[2.5] {
                if twoAndAHalfPlateCount == 0 {
                    twoAndAHalfPlateLabel.isHidden = true
                } else {
                    twoAndAHalfPlateLabel.text = "\(twoAndAHalfPlateCount) x \(plate2string)"
                    twoAndAHalfPlateLabel.isHidden = false
                }
            }
        }
    }
}

extension Double {
    
    var kilograms: Double {
        return self * 0.45359237
    }
    
}


















