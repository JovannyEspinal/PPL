//
//  Round.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/10/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct Round {

    static func roundRegular(number: Double, toNearest: Double) -> Double {
        return round(number/toNearest) * toNearest
    }
    
    // Given a value to round and a factor to round to,
    // round the value DOWN to the largest previous multiple
    // of that factor.
    static func roundDown(number: Double, toNearest: Double) -> Double {
        return floor(number / toNearest) * toNearest
    }
    
    // Given a value to round and a factor to round to,
    // round the value DOWN to the largest previous multiple
    // of that factor.
    static func roundUp(number: Double, toNearest: Double) -> Double {
        return ceil(number / toNearest) * toNearest
    }

    // Round the given value to a specified number
    // of decimal places
    static func roundToPlaces(value: Double, decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return round(value * divisor) / divisor
    }
}
