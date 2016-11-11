//
//  WorkoutFactory.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/10/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct WorkoutFactory {
    
    static func createWorkout() -> Workout {
        
        switch WorkoutManager.manager.pastWorkouts.count {
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
        
        let recentWorkouts = (lastWorkout: WorkoutManager.manager.pastWorkouts[0].type, secondToLastWorkout: WorkoutManager.manager.pastWorkouts[1].type)
        
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
    
}

// Initial workout creation methods
extension WorkoutFactory {
    static func initialPullWorkout() -> Workout {
        return Workout(type: .pull, exercises: ExerciseFactory.initialPullExercises())
    }
    
    fileprivate static func initialPushWorkout() -> Workout {
        return Workout(type: .push, exercises: ExerciseFactory.initialPullExercises())
    }
    
    fileprivate static func initialLegWorkout() -> Workout {
        return Workout(type: .legs, exercises: ExerciseFactory.initialLegExercises())
    }
    
    fileprivate static func initialAlternatePullWorkout() -> Workout {
        return Workout(type: .alternatePull, exercises: ExerciseFactory.initialAlternatePullExercises())
    }
    
    fileprivate static func initialAlternatePushWorkout() -> Workout {
        return Workout(type: .alternatePush, exercises: ExerciseFactory.initialAlternatePushExercises())
    }
}

// Updated workout creation
extension WorkoutFactory {
    fileprivate static func legWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .legs) else { fatalError() }
        
        let exercises = ExerciseFactory.updatedExercises(from: workout)
        
        return Workout(type: .legs, exercises: exercises)
    }
    
    fileprivate static func pullWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .alternatePull), let lastWorkout = mostRecentWorkout(ofType: .pull) else { fatalError() }
        
        let exercises = ExerciseFactory.pullExercises(withAccessoriesFrom: workout, andCompoundsFrom: lastWorkout)
        
        return Workout(type: .pull, exercises: exercises)
    }
    
    fileprivate static func pushWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .alternatePush), let pastWorkout = mostRecentWorkout(ofType: .push) else { fatalError() }
        
        let exercises = ExerciseFactory.pushExercises(withAccessoriesFrom: workout, andCompoundsFrom: pastWorkout)
        
        return Workout(type: .push, exercises: exercises)
    }
    
    fileprivate static func alternatePullWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .pull), let lastWorkout = mostRecentWorkout(ofType: .alternatePull) else { fatalError() }
        
        let exercises = ExerciseFactory.pullExercises(withAccessoriesFrom: workout, andCompoundsFrom: lastWorkout)
        
        return Workout(type: .alternatePull, exercises: exercises)
    }
    
    
    fileprivate static func alternatePushWorkout() -> Workout {
        guard let workout = mostRecentWorkout(ofType: .push), let pastWorkout = mostRecentWorkout(ofType: .alternatePush) else { fatalError() }
        
        let exercises = ExerciseFactory.pushExercises(withAccessoriesFrom: workout, andCompoundsFrom: pastWorkout)
        
        return Workout(type: .alternatePush, exercises: exercises)
    }
}

// Workout update helper
extension WorkoutFactory {
        static func mostRecentWorkout(ofType type: WorkoutType) -> Workout? {
        for workout in WorkoutManager.manager.pastWorkouts where workout.type == type {
            return workout
        }
        
        return nil
    }
}

// Parse saved workouts JSON and return past workouts and current workout
extension WorkoutFactory {
    static func workouts(from savedWorkoutsJSON: [String: Any]) -> (pastWorkouts: [Workout], currentWorkout: Workout) {
        
        let currentWorkoutJSON = savedWorkoutsJSON["currentWorkout"] as! [String: Any]
        let currentWorkout = workout(from: currentWorkoutJSON)
        
        let past = savedWorkoutsJSON["pastWorkouts"] as! [[String:Any]]
        
        var workouts = [Workout]()
        for workout in past {
            let savedWorkout = self.workout(from: workout)
            workouts.append(savedWorkout)
        }
        
        return (workouts, currentWorkout)
    }
    
    private static func workout(from savedWorkout: [String:Any]) -> Workout {
        let workoutType = savedWorkout["type"] as! String
        let date = Date(timeIntervalSince1970: savedWorkout["date"] as! Double)
        let exercises = savedWorkout["exercises"] as! [[String: Any]]
        
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
        
        return Workout(type: WorkoutType(rawValue: workoutType)!, exercises: allExercises, date: date)
    }
}
