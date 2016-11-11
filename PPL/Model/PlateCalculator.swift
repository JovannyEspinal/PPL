//
//  PlateCalculator.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/10/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct PlateCalculator {
    static func plates(from weight: Double) -> [Double:Int]{
        var dict = [2.5: 0,
                    5.0: 0,
                    10.0: 0,
                    25.0: 0,
                    35.0: 0,
                    45.0: 0]
        
        var adjustingWeight = (weight-45.0)/2
        
        while adjustingWeight > 0 {
            while (adjustingWeight - 45.0) >= 0 {
                adjustingWeight -= 45.0
                
                if let value = dict[45.0] {
                    dict.updateValue(value + 1, forKey: 45.0)
                }
            }
            
            while (adjustingWeight - 35.0) >= 0 {
                adjustingWeight -= 35.0
                if let value = dict[35.0] {
                    dict.updateValue(value + 1, forKey: 35.0)
                }
            }
            
            while (adjustingWeight - 25.0) >= 0 {
                adjustingWeight -= 25.0
                if let value = dict[25.0] {
                    dict.updateValue(value + 1, forKey: 25.0)
                }
            }
            
            while (adjustingWeight - 10.0) >= 0 {
                adjustingWeight -= 10.0
                if let value = dict[10.0] {
                    dict.updateValue(value + 1, forKey: 10.0)
                }
            }
            
            while (adjustingWeight - 5.0) >= 0 {
                adjustingWeight -= 5.0
                if let value = dict[5.0] {
                    dict.updateValue(value + 1, forKey: 5.0)
                }
            }
            
            while (adjustingWeight - 2.5) >= 0 {
                adjustingWeight -= 2.5
                if let value = dict[2.5] {
                    dict.updateValue(value + 1, forKey: 2.5)
                }
            }
        }
        
        return dict
    }
}
