//
//  Date+Utils.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation

extension Date {
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func daysAgo(days: Double) -> Date {
        return self.addingTimeInterval(-(days*24*60*60))
    }
    
}
