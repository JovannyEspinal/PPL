//
//  Workout.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import ObjectMapper

class Workout: ImmutableMappable {
    let type: WorkoutType
    var exercises: [Exercise]
    let date: Date
    
    init(type: WorkoutType, exercises: [Exercise], date: Date = Date()) {
        self.type = type
        self.exercises = exercises
        self.date = date
    }
    
    required init(map: Map) throws {
        type = WorkoutType(rawValue: try map.value("type"))!
        exercises = try map.value("exercises")
        date = try map.value("date")
    }
    
    func mapping(map: Map) {
        type.rawValue >>> map["type"]
        exercises <- map["exercises"]
        date >>> (map["date"], DateTransform())
    }
}

extension Workout: Equatable {
    static func ==(lhs: Workout, rhs: Workout) -> Bool {
        if lhs.type != rhs.type {
            return false
        }
        
        if lhs.exercises != rhs.exercises {
            return false
        }
        
        if lhs.date != rhs.date {
            return false
        }
        
        return true
    }
}



