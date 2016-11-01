//
//  Date+StringDate.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/25/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Date {
    func stringDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd"
        
        return formatter.string(from: self)
    }
}
