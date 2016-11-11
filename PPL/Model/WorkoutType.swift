//
//  WorkoutType.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import ObjectMapper

enum WorkoutType: String, ImmutableMappable {
    case pull = "Pull"
    case push = "Push"
    case legs = "Legs"
    case alternatePull = "Alt Pull"
    case alternatePush = "Alt Push"
    
    init(map: Map) throws {
        self = WorkoutType(rawValue: try map.value(Property.type.rawValue))!
    }
    
    mutating func mapping(map: Map) {
        self.rawValue >>> map[Property.type.rawValue]
    }
}
