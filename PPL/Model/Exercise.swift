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
    var weight: Double
    var sets: [ExerciseSet]
    let failCount: Int
}

extension Exercise {
    var kgWeight: Double {
        if weight == 45 {
            return 20
        }
        return Round.roundRegular(number: weight * 0.45359237, toNearest: 2.5)
    }
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
        name = try map.value(Property.name.rawValue)
        weight = try map.value(Property.weight.rawValue)
        sets = try map.value(Property.sets.rawValue)
        failCount = try map.value(Property.failCount.rawValue)
    }
    
    mutating func mapping(map: Map) {
        name >>> map[Property.name.rawValue]
        weight >>> map[Property.weight.rawValue]
        sets >>> map[Property.sets.rawValue]
        failCount >>> map[Property.failCount.rawValue]
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
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            return "\(self.name) \(self.sets.count)x\(self.sets[0].numberOfReps) \(self.kgWeight.cleanValue)kg"
        } else {
            return "\(self.name) \(self.sets.count)x\(self.sets[0].numberOfReps) \(self.weight.cleanValue)lbs"
        }
    }
    
    var setxWeightDescription: String {
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            return "\(self.sets.count)x\(self.sets[0].numberOfReps) \(self.kgWeight.cleanValue)kg"
        } else {
            return "\(self.sets.count)x\(self.sets[0].numberOfReps) \(self.weight.cleanValue)lbs"
        }
    }
}

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
