//
//  WorkoutManager.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import ObjectMapper


class WorkoutManager: NSObject, Mappable {
    
    static var manager = WorkoutManager()
    private override init() { }
    
    var pastWorkouts = [Workout]()
    var pastWorkoutsCount: Int { return pastWorkouts.count }
    var currentWorkout: Workout?
    
    func parse(json: [String: Any]) -> [Workout] {
        
        // Assign Current Workout
        let current = json["currentWorkout"] as! [String: Any]
        let workoutType = current["type"] as! String
        let date = Date(timeIntervalSince1970: current["date"] as! Double)
        let exercises = current["exercises"] as! [[String: Any]]
        
        var allExercises = [Exercise]()
        for exercise in exercises {
            let name = exercise["name"] as! String
            let weight = exercise["weight"] as! Double
            let failCount = exercise["failCount"] as! Int
            
            let sets = exercise["sets"] as! [[String:Any]]
            
            var exerciseSets = [ExerciseSet]()
            for set in sets {
                let numberOfRepsCompleted = set["numberOfRepsCompleted"] as! Int
                let numberOfReps = set["numberOfReps"] as! Int
                let firstAttempt = set["firstAttempt"] as! Bool
                
                let exerciseSet = ExerciseSet(numberOfReps: numberOfReps, numberOfRepsCompleted: numberOfRepsCompleted, firstAttempt: firstAttempt)
                exerciseSets.append(exerciseSet)
            }
            
            let completeExercise = Exercise(name: name, weight: weight, sets: exerciseSets, failCount: failCount)
            
            allExercises.append(completeExercise)
        }
        
        let currentWO = Workout(type: WorkoutType(rawValue: workoutType)!, exercises: allExercises, date: date)
        
        currentWorkout = currentWO
        
        //////
        
        let past = json["pastWorkouts"] as! [[String:Any]]
        
        var workouts = [Workout]()
        for workout in past {
            let workoutType = workout["type"] as! String
            let date = Date(timeIntervalSince1970: workout["date"] as! Double)
            
            let exercises = workout["exercises"] as! [[String: Any]]
            
            var allExercises = [Exercise]()
            for exercise in exercises {
                let name = exercise["name"] as! String
                let weight = exercise["weight"] as! Double
                let failCount = exercise["failCount"] as! Int
                
                let sets = exercise["sets"] as! [[String:Any]]
                
                var exerciseSets = [ExerciseSet]()
                for set in sets {
                    let numberOfRepsCompleted = set["numberOfRepsCompleted"] as! Int
                    let numberOfReps = set["numberOfReps"] as! Int
                    let firstAttempt = set["firstAttempt"] as! Bool
                    
                    let exerciseSet = ExerciseSet(numberOfReps: numberOfReps, numberOfRepsCompleted: numberOfRepsCompleted, firstAttempt: firstAttempt)
                    exerciseSets.append(exerciseSet)
                }
                
                let completeExercise = Exercise(name: name, weight: weight, sets: exerciseSets, failCount: failCount)
                
                allExercises.append(completeExercise)
            }
            
            
            workouts.append(Workout(type: WorkoutType(rawValue: workoutType)!, exercises: allExercises, date: date))
        }
        
        return workouts
    }
    
    required init?(map: Map) {
        pastWorkouts <- map["pastWorkouts"]
        currentWorkout <- map["currentWorkout"]
    }
    
    func mapping(map: Map) {
        pastWorkouts <- map["pastWorkouts"]
        currentWorkout <- map["currentWorkout"]
    }
    
    func add(_ workout: Workout) {
        pastWorkouts.insert(workout, at: 0)
        currentWorkout = self.createWorkout()
    }
    
    func createWorkout() -> Workout {
        
        switch pastWorkouts.count {
        case 0:
            return initialPullWorkout()
        case 1:
            return initialPushWorkout()
        case 2:
            return initialLegWorkout()
        case 3:
            return initialAlternatePullWorkout()
        case 4:
            return initialAlternatePushWorkout()
        default:
            break
        }
        
        let recentWorkouts = (lastWorkout: pastWorkouts[0].type, secondToLastWorkout: pastWorkouts[1].type)
        
        switch recentWorkouts {
        case (.alternatePush, _):
            return legWorkout()
        case (.alternatePull, _):
            return alternatePushWorkout()
        case (.legs, .push):
            return alternatePullWorkout()
        case (.push, _):
            return legWorkout()
        case (.pull, _):
            return pushWorkout()
        case (.legs, .alternatePush):
            return pullWorkout()
        default:
            break
        }
        
        return Workout(type: .pull, exercises: [Exercise]())
    }
    
    func workout(atIndex index: Int) -> Workout? {
        guard index < pastWorkouts.count else { return nil }
        
        return pastWorkouts[index]
    }
    
    func removeWorkout(atIndex index: Int) {
        pastWorkouts.remove(at: index)
    }
    
    func removeAllWorkouts() {
        pastWorkouts.removeAll()
        currentWorkout = initialPullWorkout()
    }
}

// MARK: Workout Templates
extension WorkoutManager {
    func initialPullWorkout() -> Workout {
        let deadlift = Exercise(name: ExerciseNames.deadlift, weight: 90.0, numberOfSets: 1, numberOfReps: 5)
        let pulldown = Exercise(name: ExerciseNames.pulldown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let seatedCableRow = Exercise(name: ExerciseNames.seatedCableRow, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let facePull = Exercise(name: ExerciseNames.facePull, weight: 10.0, numberOfSets: 5, numberOfReps: 20)
        let hammerCurl = Exercise(name: ExerciseNames.hammerCurl, weight: 10.0, numberOfSets: 4, numberOfReps: 12)
        let dumbbellCurl = Exercise(name: ExerciseNames.dumbbellCurl, weight: 10.0, numberOfSets: 4, numberOfReps: 12)
        
        let exercises = [deadlift, pulldown, seatedCableRow, facePull, hammerCurl, dumbbellCurl]
        
        return Workout(type: .pull, exercises: exercises)
    }
    
    func initialPushWorkout() -> Workout {
        let benchPress = Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        let overheadPress = Exercise(name: ExerciseNames.overheadPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let inclineDumbbellPress = Exercise(name: ExerciseNames.inclineDumbellPress, weight: 15, numberOfSets: 3, numberOfReps: 12)
        let tricepsPushdown = Exercise(name: ExerciseNames.tricepsPushdown, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let lateralRaises1 = Exercise(name: ExerciseNames.lateralRaise, weight: 10.0, numberOfSets: 3, numberOfReps: 20)
        let overheadTricepsExtension = Exercise(name: ExerciseNames.overheadTricepsExtension, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        let lateralRaises2 = Exercise(name: ExerciseNames.lateralRaise, weight: 10.0, numberOfSets: 3, numberOfReps: 20)
        
        let exercises = [benchPress, overheadPress, inclineDumbbellPress, tricepsPushdown, lateralRaises1, overheadTricepsExtension, lateralRaises2]
        
        return Workout(type: .push, exercises: exercises)
    }
    
    func initialLegWorkout() -> Workout {
        let squat = Exercise(name: ExerciseNames.squat, weight: 135.0, numberOfSets: 3, numberOfReps: 5)
        let romanianDeadlift = Exercise(name: ExerciseNames.romanianDeadlift, weight: 135.0, numberOfSets: 3, numberOfReps: 12)
        let legPress = Exercise(name: ExerciseNames.legPress, weight: 225.0, numberOfSets: 3, numberOfReps: 12)
        let legCurl = Exercise(name: ExerciseNames.legCurl, weight: 70.0, numberOfSets: 3, numberOfReps: 12)
        let calfRaise = Exercise(name: ExerciseNames.calfRaise, weight: 45.0, numberOfSets: 5, numberOfReps: 20)
        
        let exercises = [squat, romanianDeadlift, legPress, legCurl, calfRaise]
        
        return Workout(type: .legs, exercises: exercises)
    }
    
    func initialAlternatePullWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .pull) else { fatalError() }
        
        let barbellRow = Exercise(name: ExerciseNames.barbellRow, weight: 45.0, numberOfSets: 5, numberOfReps: 5)
        
        var exercises = updatedExercises(from: workout)
        exercises.removeFirst()
        exercises.insert(barbellRow, at: 0)
        
        
        return Workout(type: .alternatePull, exercises: exercises)
    }
    
    func initialAlternatePushWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .push) else { fatalError() }
        
        let overheadPress = Exercise(name: ExerciseNames.overheadPress, weight: 50.0, numberOfSets: 5, numberOfReps: 5)
        
        let benchPress = Exercise(name: ExerciseNames.benchPress, weight: 45.0, numberOfSets: 3, numberOfReps: 12)
        
        var exercises = updatedExercises(from: workout)
        exercises.removeSubrange(0...1)
        exercises.insert(contentsOf: [overheadPress, benchPress], at: 0)
        
        return Workout(type: .alternatePush, exercises: exercises)
    }
}

// MARK: Workout Creation
extension WorkoutManager {
    func legWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .legs) else { fatalError() }
        
        let exercises = updatedExercises(from: workout)
        
        return Workout(type: .legs, exercises: exercises)
    }
    
    func pullWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .alternatePull), let lastWorkout = mostRecentWorkout(ofType: .pull) else { fatalError() }
        
        let exercises = pullExercises(withAccessoriesFrom: workout, andCompoundsFrom: lastWorkout)
        
        return Workout(type: .pull, exercises: exercises)
    }
    
    func pushWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .alternatePush), let pastWorkout = mostRecentWorkout(ofType: .push) else { fatalError() }
        
        let exercises = pushExercises(withAccessoriesFrom: workout, andCompoundsFrom: pastWorkout)
        
        return Workout(type: .push, exercises: exercises)
    }
    
    func alternatePullWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .pull), let lastWorkout = mostRecentWorkout(ofType: .alternatePull) else { fatalError() }
        
        let exercises = pullExercises(withAccessoriesFrom: workout, andCompoundsFrom: lastWorkout)
        
        return Workout(type: .alternatePull, exercises: exercises)
    }
    
    
    func alternatePushWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .push), let pastWorkout = mostRecentWorkout(ofType: .alternatePush) else { fatalError() }
        
        let exercises = pushExercises(withAccessoriesFrom: workout, andCompoundsFrom: pastWorkout)
        
        return Workout(type: .alternatePush, exercises: exercises)
    }
}


// MARK: Helpers
extension WorkoutManager {
    func mostRecentWorkout(ofType type: WorkoutType) -> Workout? {
        
        for workout in pastWorkouts where workout.type == type {
            return workout
        }
        return nil
    }
    
    func pushExercises(withAccessoriesFrom workout: Workout, andCompoundsFrom lastWorkout: Workout) -> [Exercise] {
        let updatedExercisesLastWorkout = updatedExercises(from: lastWorkout)
        
        let firstExercise = updatedExercisesLastWorkout[0]
        let secondExercise = updatedExercisesLastWorkout[1]
        
        var exercises = updatedExercises(from: workout)
        exercises.removeSubrange(0...1)
        exercises.insert(contentsOf: [firstExercise, secondExercise], at: 0)
        
        return exercises
    }
    
    func pullExercises(withAccessoriesFrom workout: Workout, andCompoundsFrom lastWorkout: Workout) -> [Exercise] {
        let updatedExercisesLastWorkout = updatedExercises(from: lastWorkout)
        
        let firstExercise = updatedExercisesLastWorkout[0]
        
        var exercises = updatedExercises(from: workout)
        exercises.removeFirst()
        exercises.insert(firstExercise, at: 0)
        
        return exercises
    }
    
    func updatedExercises(from workout: Workout) -> [Exercise] {
        var updatedExercises = [Exercise]()
        
        for pastexercise in workout.exercises {
            
            let updatedExercise: Exercise
            let compoundExercises = [ExerciseNames.deadlift, ExerciseNames.barbellRow, ExerciseNames.benchPress, ExerciseNames.overheadPress, ExerciseNames.squat]
            
            if pastexercise.hasCompletedAllSets() {
                let incrementAmount: Double
                
                if compoundExercises.contains(pastexercise.name) {
                    if pastexercise.name == ExerciseNames.deadlift {
                        incrementAmount = 10.0
                    } else {
                        incrementAmount = 5.0
                    }
                } else {
                    incrementAmount = 2.5
                }
                
                let adjustedExercise = (pastexercise |> Exercise.weightLens *~ (pastexercise.weight + incrementAmount)) |> Exercise.failCountLens *~ 0
                
                updatedExercise = adjustedExercise
            } else {
                let adjustedExercise = pastexercise |> Exercise.failCountLens *~ (pastexercise.failCount + 1)
                
                if adjustedExercise.failCount == 3 {
                    let deloadAmount = adjustedExercise.weight * 0.1
                    let newWeightTotal = round(((pastexercise.weight - deloadAmount) / 2.5)) * 2.5
                    let deloadedExercise = (adjustedExercise |> Exercise.weightLens *~ newWeightTotal) |> Exercise.failCountLens *~ 0
                    updatedExercise = deloadedExercise
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



























