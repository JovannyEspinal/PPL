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
        numberOfRepsCompleted = try map.value("numberOfRepsCompleted")
        numberOfReps = try map.value("numberOfReps")
        firstAttempt = try map.value("firstAttempt")
    }
    
    mutating func mapping(map: Map) {
        numberOfRepsCompleted >>> map["numberOfRepsCompleted"]
        numberOfReps >>> map["numberOfReps"]
        firstAttempt >>> map["firstAttempt"]
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








