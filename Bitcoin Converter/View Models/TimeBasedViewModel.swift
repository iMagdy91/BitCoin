//
//  TimeBasedVIewModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation

class TimeBasedViewModel {
    
    weak var timer: Timer?

    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
}
