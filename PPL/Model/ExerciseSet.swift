//
//  ExerciseSet.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import ObjectMapper

struct ExerciseSet: ImmutableMappable {
    let numberOfRepsCompleted: Int
    let numberOfReps: Int
    let firstAttempt: Bool
    
    init(numberOfReps: Int, numberOfRepsCompleted: Int = 0, firstAttempt: Bool = true) {
        self.numberOfReps = numberOfReps
        self.numberOfRepsCompleted = numberOfRepsCompleted
        self.firstAttempt = firstAttempt
    }
    
    init(map: Map) throws {
        numberOfRepsCompleted = try map.value(Property.numberOfRepsCompleted.rawValue)
        numberOfReps = try map.value(Property.numberOfReps.rawValue)
        firstAttempt = try map.value(Property.firstAttempt.rawValue)
    }
    
    mutating func mapping(map: Map) {
        numberOfRepsCompleted >>> map[Property.numberOfRepsCompleted.rawValue]
        numberOfReps >>> map[Property.numberOfReps.rawValue]
        firstAttempt >>> map[Property.firstAttempt.rawValue]
    }
}

extension ExerciseSet: Equatable {
    static func ==(lhs: ExerciseSet, rhs: ExerciseSet) -> Bool {
        if lhs.numberOfReps != rhs.numberOfReps {
            return false
        }
        
        return true
    }
    
    func hasMetRepGoal() -> Bool {
        return numberOfRepsCompleted >= numberOfReps
    }
}
