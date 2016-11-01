//
//  Lens + ExerciseSet.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

extension ExerciseSet {
    static let numberOfRepsLens = Lens<ExerciseSet, Int>(
        get: { $0.numberOfReps },
        set: { (reps, set) in ExerciseSet(numberOfReps: reps, numberOfRepsCompleted: set.numberOfRepsCompleted, firstAttempt: set.firstAttempt) }
    )
    
    static let numberOfRepsCompletedLens = Lens<ExerciseSet, Int>(
        get: { $0.numberOfRepsCompleted },
        set: { (repsCompleted, set) in ExerciseSet(numberOfReps: set.numberOfReps, numberOfRepsCompleted: repsCompleted, firstAttempt: set.firstAttempt) }
    )
    
    static let firstAttemptLens = Lens<ExerciseSet, Bool>(
        get: { $0.firstAttempt },
        set: { (firstAttempt, set) in ExerciseSet(numberOfReps: set.numberOfReps, numberOfRepsCompleted: set.numberOfRepsCompleted, firstAttempt: firstAttempt) }
    )
}
