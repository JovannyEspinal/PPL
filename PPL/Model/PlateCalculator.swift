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
        let plate2string: Double
        let plate5string: Double
        let plate10string: Double
        let plate25string: Double
        let plate35string: Double
        let plate45string: Double
        
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            plate2string = 1.25
            plate5string = 2.5
            plate10string = 5.0
            plate25string = 11.25
            plate35string = 16.5
            plate45string = 20.0
            
        } else {
            plate2string = 2.5
            plate5string = 5.0
            plate10string = 10.0
            plate25string = 25.0
            plate35string = 35.0
            plate45string = 45.0
        }
        
        var dict = [plate2string: 0,
                    plate5string: 0,
                    plate10string: 0,
                    plate25string: 0,
                    plate35string: 0,
                    plate45string: 0]
        
        var adjustingWeight = (weight-plate45string)/2
        
        
        while (adjustingWeight - plate45string) >= 0 {
            adjustingWeight -= plate45string
            if let value = dict[plate45string] {
                dict.updateValue(value + 1, forKey: plate45string)
            }
        }
        
        while (adjustingWeight - plate35string) >= 0 {
            adjustingWeight -= plate35string
            if let value = dict[plate35string] {
                dict.updateValue(value + 1, forKey: plate35string)
            }
        }
        
        while (adjustingWeight - plate25string) >= 0 {
            adjustingWeight -= plate25string
            if let value = dict[plate25string] {
                dict.updateValue(value + 1, forKey: plate25string)
            }
        }
        
        while (adjustingWeight - plate10string) >= 0 {
            adjustingWeight -= plate10string
            if let value = dict[plate10string] {
                dict.updateValue(value + 1, forKey: plate10string)
            }
        }
        
        while (adjustingWeight - plate5string) >= 0 {
            adjustingWeight -= plate5string
            if let value = dict[plate5string] {
                dict.updateValue(value + 1, forKey: plate5string)
            }
        }
        
        while (adjustingWeight - plate2string) >= 0 {
            adjustingWeight -= plate2string
            if let value = dict[plate2string] {
                dict.updateValue(value + 1, forKey: plate2string)
            }
        }
        
        return dict
    }
}
