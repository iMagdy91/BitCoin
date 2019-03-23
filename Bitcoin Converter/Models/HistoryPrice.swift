//
//  HistoryPrice.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import EVReflection

class HistoryPrice: EVObject {
    
    var bpi: [String : Double] = [String : Double]()
    var disclaimer: String?
    var time: TimeModel?
    
    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        if key == "bpi" {
            if let dict = value as? NSDictionary {
                dict.forEach {
                    bpi[$0.key as? String ?? ""] = $0.value as? Double ?? 0.0
                }

            }
        }
    }
}
