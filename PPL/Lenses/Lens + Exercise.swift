//
//  Lens + Exercise.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Exercise {
    static let nameLens = Lens<Exercise, String>(
        get: { $0.name },
        set: { (name, exercise) in Exercise(name: name, weight: exercise.weight, sets: exercise.sets, failCount: exercise.failCount) }
    )
    
    static let weightLens = Lens<Exercise, Double>(
        get: { $0.weight },
        set: { (weight, exercise) in Exercise(name: exercise.name, weight: weight, sets: exercise.sets, failCount: exercise.failCount) }
    )
    
    static let setsLens = Lens<Exercise, [ExerciseSet]>(
        get: { $0.sets },
        set: { (sets, exercise) in Exercise(name: exercise.name, weight: exercise.weight, sets: sets, failCount: exercise.failCount) }
    )
    
    static let failCountLens = Lens<Exercise, Int>(
        get: { $0.failCount },
        set: { (failCount, exercise) in Exercise(name: exercise.name, weight: exercise.weight, sets: exercise.sets, failCount: failCount) }
    )
    
}
