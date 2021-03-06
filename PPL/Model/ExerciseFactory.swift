//
//  ExerciseManager.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/10/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct ExerciseFactory {
    
    //MARK: - Initial Exercises Creation
    static func initialPullExercises() -> [Exercise] {
        let deadlift = Exercise(name: ExerciseNames.deadlift, weight: 90.0, numberOfSets: 1, numberOfReps: 5)
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let seatedCableRow = Exercise(name: ExerciseNames.seatedCableRow, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let facePull = Exercise(name: ExerciseNames.facePull, weight: 10.0, numberOfSets: 5, numberOfReps: 20)
        let hammerCurl = Exercise(name: ExerciseNames.hammerCurl, weight: 10.0, numberOfSets: 4, numberOfReps: 12)
        let dumbbellCurl = Exercise(name: ExerciseNames.dumbbellCurl, weight: 10.0, numberOfSets: 4, numberOfReps: 12)
        
        let exercises = [deadlift, pulldown, seatedCableRow, facePull, hammerCurl, dumbbellCurl]
        
        return exercises
    }
    
    static func initialPushExercises() -> [Exercise] {
        let benchPress = Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        let overheadPress = Exercise(name: ExerciseNames.overheadPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let inclineDumbbellPress = Exercise(name: ExerciseNames.inclineDumbellPress, weight: 15, numberOfSets: 3, numberOfReps: 12)
        let tricepsPushdown = Exercise(name: ExerciseNames.tricepsPushdown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let lateralRaises1 = Exercise(name: ExerciseNames.lateralRaise, weight: 10.0, numberOfSets: 3, numberOfReps: 20)
        let overheadTricepsExtension = Exercise(name: ExerciseNames.overheadTricepsExtension, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let lateralRaises2 = Exercise(name: ExerciseNames.lateralRaise, weight: 10.0, numberOfSets: 3, numberOfReps: 20)
        
        let exercises = [benchPress, overheadPress, inclineDumbbellPress, tricepsPushdown, lateralRaises1, overheadTricepsExtension, lateralRaises2]
        
        return exercises
    }
    
    static func initialLegExercises() -> [Exercise] {
        let squat = Exercise(name: ExerciseNames.squat, weight: 135.0, numberOfSets: 3, numberOfReps: 5)
        let romanianDeadlift = Exercise(name: ExerciseNames.romanianDeadlift, weight: 135.0, numberOfSets: 3, numberOfReps: 12)
        let legPress = Exercise(name: ExerciseNames.legPress, weight: 225.0, numberOfSets: 3, numberOfReps: 12)
        let legCurl = Exercise(name: ExerciseNames.legCurl, weight: 70.0, numberOfSets: 3, numberOfReps: 12)
        let calfRaise = Exercise(name: ExerciseNames.calfRaise, weight: 45.0, numberOfSets: 5, numberOfReps: 20)
        
        let exercises = [squat, romanianDeadlift, legPress, legCurl, calfRaise]
        
        return exercises
    }
    
    static func initialAlternatePullExercises() -> [Exercise] {
        guard let workout = WorkoutFactory.mostRecentWorkout(ofType: .pull) else { fatalError() }
        
        let barbellRow = Exercise(name: ExerciseNames.barbellRow, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        
        var exercises = ExerciseFactory.updatedExercises(from: workout)
        exercises.removeFirst()
        exercises.insert(barbellRow, at: 0)
        
        return exercises
    }
    
    static func initialAlternatePushExercises() -> [Exercise] {
        guard let workout = WorkoutFactory.mostRecentWorkout(ofType: .push) else { fatalError() }
        
        let overheadPress = Exercise(name: ExerciseNames.overheadPress, weight: 50.0, numberOfSets: 5, numberOfReps: 5)
        
        let benchPress = Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        var exercises = ExerciseFactory.updatedExercises(from: workout)
        exercises.removeSubrange(0...1)
        exercises.insert(contentsOf: [overheadPress, benchPress], at: 0)
        
        return exercises
    }
}

//MARK: Updated Exercises Creation
extension ExerciseFactory {
    static func pushExercises(withAccessoriesFrom workout: Workout,
                              andCompoundsFrom lastWorkout: Workout) -> [Exercise] {
        let updatedExercisesLastWorkout = updatedExercises(from: lastWorkout)
        
        let firstExercise = updatedExercisesLastWorkout[0]
        let secondExercise = updatedExercisesLastWorkout[1]
        
        var exercises = updatedExercises(from: workout)
        exercises.removeSubrange(0...1)
        exercises.insert(contentsOf: [firstExercise, secondExercise], at: 0)
        
        return exercises
    }
    
    static func pullExercises(withAccessoriesFrom workout: Workout,
                              andCompoundsFrom lastWorkout: Workout) -> [Exercise] {
        let updatedExercisesLastWorkout = updatedExercises(from: lastWorkout)
        
        let firstExercise = updatedExercisesLastWorkout[0]
        
        var exercises = updatedExercises(from: workout)
        exercises.removeFirst()
        exercises.insert(firstExercise, at: 0)
        
        return exercises
    }
    
    static func updatedExercises(from workout: Workout) -> [Exercise] {
        var updatedExercises = [Exercise]()
        
        for pastExercise in workout.exercises {
            let compoundExercises = [ExerciseNames.deadlift,
                                     ExerciseNames.barbellRow,
                                     ExerciseNames.benchPress,
                                     ExerciseNames.overheadPress,
                                     ExerciseNames.squat]
            let updatedExercise: Exercise
            var adjustedExercise: Exercise
            var incrementAmount: Double
            let maximumReps: Int
            let minimumReps: Int
            
            if pastExercise.name == ExerciseNames.facePull || pastExercise.name == ExerciseNames.lateralRaise || pastExercise.name == ExerciseNames.calfRaise {
                maximumReps = 20
                minimumReps = 16
            } else {
                maximumReps = 12
                minimumReps = 8
            }
            
            if pastExercise.hasCompletedAllSets() {
                if compoundExercises.contains(pastExercise.name) {
                    if pastExercise.name == ExerciseNames.deadlift {
                        incrementAmount = 10.0
                    } else {
                        incrementAmount = 5.0
                    }
                } else {
                    incrementAmount = 2.5
                }
                
                var updatedSets = [ExerciseSet]()
                if let firstExercise = workout.exercises.first?.name, firstExercise != pastExercise.name {
                    for set in pastExercise.sets {
                        
                        if set.numberOfReps == maximumReps {
                            let updatedSet = set |> ExerciseSet.numberOfRepsLens *~ minimumReps
                            updatedSets.append(updatedSet)
                        } else {
                            let updatedSet = set |> ExerciseSet.numberOfRepsLens *~ (set.numberOfReps + 1)
                            incrementAmount = 0
                            updatedSets.append(updatedSet)
                        }
                    }
                    
                    adjustedExercise = (pastExercise |> Exercise.weightLens *~ (pastExercise.weight + incrementAmount)
                        |> Exercise.failCountLens *~ 0
                        |> Exercise.setsLens *~ updatedSets)
                    
                } else {
                    adjustedExercise = (pastExercise |> Exercise.weightLens *~ (pastExercise.weight + incrementAmount)
                        |> Exercise.failCountLens *~ 0)
                    
                }
                
                updatedExercise = adjustedExercise
            } else {
                let adjustedExercise = pastExercise |> Exercise.failCountLens *~ (pastExercise.failCount + 1)
                
                if adjustedExercise.failCount == 3 {
                    let deloadedExercise: Exercise
                    
                    if let firstExercise = workout.exercises.first?.name, firstExercise == pastExercise.name {
                        let deloadAmount = adjustedExercise.weight * 0.1
                        let newWeightTotal = Round.roundRegular(number: pastExercise.weight - deloadAmount, toNearest: 5.0)
                        deloadedExercise = (adjustedExercise |> Exercise.weightLens *~ newWeightTotal)
                    } else {
                        var updatedSets = [ExerciseSet]()
                        var deloadAmount: Double = 0
                        
                        for set in adjustedExercise.sets {
                            var updatedSet = set |> ExerciseSet.numberOfRepsLens *~ (set.numberOfReps - 1)
                            
                            if set.numberOfReps < minimumReps {
                                deloadAmount = adjustedExercise.weight - 2.5
                                updatedSet = (set |> ExerciseSet.numberOfRepsLens *~ maximumReps)
                            }
                            
                            updatedSets.append(updatedSet)
                        }
                        
                        deloadedExercise = ((adjustedExercise |> Exercise.setsLens *~ updatedSets)
                            |> Exercise.weightLens *~ (adjustedExercise.weight - deloadAmount))
                    }
                    
                    
                    updatedExercise = (deloadedExercise |> Exercise.failCountLens *~ 0)
                } else {
                    updatedExercise = adjustedExercise
                }
            }
            
            var updatedSets = [ExerciseSet]()
            for set in updatedExercise.sets {
                let updatedSet = (set |> ExerciseSet.firstAttemptLens *~ true) |> ExerciseSet.numberOfRepsCompletedLens *~ 0
                
                updatedSets.append(updatedSet)
            }
            
            let updatedExerciseWithNewSets = updatedExercise |> Exercise.setsLens *~ updatedSets
            
            updatedExercises.append(updatedExerciseWithNewSets)
        }
        
        return updatedExercises
    }
}
