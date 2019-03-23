//
//  CurrentPrice.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import EVReflection

class CurrentPrice: EVObject {
    var time: TimeModel?
    var disclaimer: String?
    var bpi: [String : CurrencyRate] = [String : CurrencyRate]()    
    
    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        if key == "bpi" {
            if let dict = value as? NSDictionary {
                dict.forEach {
                    bpi[$0.key as? String ?? ""] = CurrencyRate(dictionary: $0.value as? NSDictionary ?? NSDictionary())
                }

            }
        }
    }
}

class TimeModel: EVObject {
    var updated: String?
    var updatedISO: String?
    var updateduk: String?
}

class CurrencyRate: EVObject {
    var code: String?
    var _description: String?
    var rate: String?
    var rate_float: Double = 0
    var symbol: String?
    
    override func propertyMapping() -> [(keyInObject:String?, keyInResource:String?)] {
        return [(keyInObject: "_description", keyInResource: "description")]
    }
    
}
