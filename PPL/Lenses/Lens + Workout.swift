//
//  Lens + Workout.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//
import Foundation

extension Workout {
    static let typeLens = Lens<Workout, WorkoutType>(
        get: { $0.type },
        set: { (workoutType, workout) in Workout(type: workoutType, exercises: workout.exercises, date: workout.date) }
    )
    
    static let exercisesLens = Lens<Workout, [Exercise]>(
        get: { $0.exercises },
        set: { (exercises, workout) in Workout(type: workout.type, exercises: exercises, date: workout.date) }
    )
    
    static let dateLens = Lens<Workout, Date>(
        get: { $0.date },
        set: { (date, workout) in Workout(type: workout.type, exercises: workout.exercises, date: date) }
    )
}
