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
    @IBOutlet weak var weightTextLabel: UILabel!
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
            if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
                weight = WorkoutManager.manager.currentWorkout?.exercises[index].kgWeight
            } else {
                weight = WorkoutManager.manager.currentWorkout?.exercises[index].weight
            }
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
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            weight = compoundExercises.contains(exerciseName) ? updatedWeight + 2.5 : updatedWeight + 1.25
        }
        else {
            weight = compoundExercises.contains(exerciseName) ? updatedWeight + 5.0 : updatedWeight + 2.5
        }
        updateLabel()
    }
    
    @IBAction func decrementWeight() {
        guard let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, let updatedWeight = weight else { return }
        
        if updatedWeight == 0 { return }
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            weight = compoundExercises.contains(exerciseName) ? updatedWeight - 2.5 : updatedWeight - 1.25
        }
        else {
            weight = compoundExercises.contains(exerciseName) ? updatedWeight - 5.0 : updatedWeight - 2.5
        }
        
        updateLabel()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        
        guard let exercise = WorkoutManager.manager.currentWorkout?.exercises[index], let updatedWeight = weight else {
            return
        }
        
        let updatedExercise: Exercise
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            updatedExercise = (exercise |> Exercise.weightLens *~ Round.roundUp(number: updatedWeight * 2.20462262185, toNearest: 2.5))
        } else {
            updatedExercise = (exercise |> Exercise.weightLens *~ updatedWeight)
        }
        
        WorkoutManager.manager.currentWorkout?.exercises[index] = updatedExercise
        
        print(WorkoutManager.manager.currentWorkout!.exercises[index].kgWeight)
        print(updatedWeight)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func updateLabel() {
        guard let updatedWeight = weight else { return }
        
        guard let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name else { return }
        
        let barbell: Double
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            
            weightTextLabel.text = "\(updatedWeight)"
            barbell = 20
            
            if barbellExercises.contains(exerciseName) {
                navigationBar.topItem?.title = updatedWeight <= barbell ? "Lift The Empty Bar" : "Add \((updatedWeight-barbell)/2)kg/side"
            } else {
                navigationBar.topItem?.title = "Change Exercise Weight"
            }
            
            addOnEachSideLabel.text = "Add on each side of \(barbell)kg barbell"
        } else {
            weightTextLabel.text = "\(updatedWeight)"
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let weakSelf = self else {return}
            
            let plates = PlateCalculator.plates(from: weakSelf.weight!)
            
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else {return}
                weakSelf.updatePlateLabels(with: plates)
            }
            
        }
    }
    
    func updatePlateLabels(with plates: [Double: Int]) {
        let plate2string: String
        let plate5string: String
        let plate10string: String
        let plate25string: String
        let plate35string: String
        let plate45string: String
        
        let plate2value: Double
        let plate5value: Double
        let plate10value: Double
        let plate25value: Double
        let plate35value: Double
        let plate45value: Double
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            plate2string = "1.25kg"
            plate5string = "2.5kg"
            plate10string = "5kg"
            plate25string = "11.25kg"
            plate35string = "16.5kg"
            plate45string = "20kg"
            
            plate2value = 1.25
            plate5value = 2.5
            plate10value = 5.0
            plate25value = 11.25
            plate35value = 16.5
            plate45value = 20.0
            
        } else {
            plate2string = "2.5lb"
            plate5string = "5lb"
            plate10string = "10lb"
            plate25string = "25lb"
            plate35string = "35lb"
            plate45string = "45lb"
            
            plate2value = 2.5
            plate5value = 5.0
            plate10value = 10.0
            plate25value = 25.0
            plate35value = 35.0
            plate45value = 45.0
        }
        
        if let exerciseName = WorkoutManager.manager.currentWorkout?.exercises[index].name, barbellExercises.contains(exerciseName) {
            if let fortyFivePlateCount = plates[plate45value] {
                if fortyFivePlateCount == 0 {
                    fortyFivePlateLabel.isHidden = true
                } else {
                    fortyFivePlateLabel.text = "\(fortyFivePlateCount) x \(plate45string)"
                    fortyFivePlateLabel.isHidden = false
                }
            }
            
            if let thirtyFivePlateCount = plates[plate35value] {
                if thirtyFivePlateCount == 0 {
                    thirtyFivePlateLabel.isHidden = true
                } else {
                    thirtyFivePlateLabel.text = "\(thirtyFivePlateCount) x \(plate35string)"
                    thirtyFivePlateLabel.isHidden = false
                }
            }
            
            if let twentyFivePlateCount = plates[plate25value] {
                if twentyFivePlateCount == 0 {
                    twentyFivePlateLabel.isHidden = true
                } else {
                    twentyFivePlateLabel.text = "\(twentyFivePlateCount) x \(plate25string)"
                    twentyFivePlateLabel.isHidden = false
                }
            }
            
            if let tenPlateCount = plates[plate10value] {
                if tenPlateCount == 0 {
                    tenPlateLabel.isHidden = true
                } else {
                    tenPlateLabel.text = "\(tenPlateCount) x \(plate10string)"
                    tenPlateLabel.isHidden = false
                }
            }
            
            if let fivePlateCount = plates[plate5value] {
                if fivePlateCount == 0 {
                    fivePlateLabel.isHidden = true
                } else {
                    fivePlateLabel.text = "\(fivePlateCount) x \(plate5string)"
                    fivePlateLabel.isHidden = false
                }
            }
            
            if let twoAndAHalfPlateCount = plates[plate2value] {
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
        return Round.roundRegular(number: self * 0.45359237, toNearest: 2.5)
    }
    
}
