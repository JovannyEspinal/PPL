//
//  Exercise.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import ObjectMapper

struct Exercise {
    let name: String
    let weight: Double
    var sets: [ExerciseSet]
    let failCount: Int
}


extension Exercise: ImmutableMappable {
    init(name: String, weight: Double, numberOfSets: Int, numberOfReps: Int, failCount: Int = 0) {
        self.name = name
        self.weight = weight
        
        var tempSets = [ExerciseSet]()
        for _ in 1...numberOfSets {
            let set = ExerciseSet(numberOfReps: numberOfReps)
            tempSets.append(set)
        }
        
        self.sets = tempSets
        
        self.failCount = failCount
    }
    
    init(map: Map) throws {
        name = try map.value("name")
        weight = try map.value("weight")
        sets = try map.value("sets")
        failCount = try map.value("failCount")
    }
    
    mutating func mapping(map: Map) {
        name >>> map["name"]
        weight >>> map["weight"]
        sets >>> map["sets"]
        failCount >>> map["failCount"]
    }
}

extension Exercise {
    func hasCompletedAllSets() -> Bool {
        for set in sets where !set.hasMetRepGoal() {
            return false
        }
        return true
    }
}

extension Exercise: Equatable {
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        
        if lhs.name != rhs.name {
            return false
        }
        
        if lhs.weight != rhs.weight {
            return false
        }
        
        if lhs.sets.count != rhs.sets.count {
            return false
        }
        
        if lhs.failCount != rhs.failCount {
            return false
        }
        
        for index in 0..<lhs.sets.count {
            if lhs.sets[index] != rhs.sets[index] {
                return false
            }
        }
        
        return true
    }
}

extension Exercise: CustomStringConvertible {
    var description: String {
        return "\(self.name) \(self.sets.count)x\(self.sets[0].numberOfReps) \(self.weight.cleanValue)lbs"
    }
    
    var setxWeightDescription: String {
        return "\(self.sets.count)x\(self.sets[0].numberOfReps) \(self.weight.cleanValue)lbs"
    }
}

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


