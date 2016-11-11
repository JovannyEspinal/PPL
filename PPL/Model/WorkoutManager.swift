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
    
    var currentWorkout: Workout?
    var pastWorkouts = [Workout]()
    var pastWorkoutsCount: Int { return pastWorkouts.count }
    
    required init?(map: Map) {
        pastWorkouts <- map["pastWorkouts"]
        currentWorkout <- map["currentWorkout"]
    }
    
    func mapping(map: Map) {
        pastWorkouts <- map["pastWorkouts"]
        currentWorkout <- map["currentWorkout"]
    }
}

extension WorkoutManager {
    func add(_ workout: Workout) {
        pastWorkouts.insert(workout, at: 0)
        currentWorkout = WorkoutFactory.createWorkout()
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
        currentWorkout = WorkoutFactory.initialPullWorkout()
    }
}
