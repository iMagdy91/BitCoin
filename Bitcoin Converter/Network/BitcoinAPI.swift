//
//  BitcoinAPI.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import Alamofire

enum BitcoinAPI {
    
    static func getCurrentRate(forCurrency currencyCode: String?) -> Webservice<CurrentPrice> {
        let path = currencyCode == nil ? "currentprice.json" : "currentprice/\(currencyCode!).json"
        return Webservice(path: path)
    }
    
    static func getRateHistory(forCurrency currencyCode: String,
                               fromDate startDate: Date,
                               toDate endDate: Date) -> Webservice<HistoryPrice> {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        let startDateStr = dateformatter.string(from: startDate)
        let endDateStr = dateformatter.string(from: endDate)
        
        return Webservice(path: "historical/close.json",
                          parameters: ["currency" : currencyCode,
                                       "start" : startDateStr,
                                       "end" : endDateStr],
                          encoding: URLEncoding.queryString)
    }
    
}
