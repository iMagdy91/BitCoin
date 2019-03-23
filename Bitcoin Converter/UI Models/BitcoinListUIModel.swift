//
//  BitcoinListUIModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation

//MARK: - UI Model

class BitcoinListUIModel {
    
    //MARK: - Properties
    
    private(set) var rateDate: Date?
    private(set) var currencyName: String?
    private(set) var currencyCode: String?
    private(set) var exchangeRate: Double?
    
    //MARK: - Init
    
    init(currentPrice: CurrentPrice) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        rateDate = dateFormatter.date(from: currentPrice.time?.updatedISO ?? "")
        currencyName = currentPrice.bpi[currency.rawValue]?._description
        currencyCode = currentPrice.bpi[currency.rawValue]?.code
        exchangeRate = currentPrice.bpi[currency.rawValue]?.rate_float
    }
    
    init(date: String, rate: Double, currencyCode: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        rateDate = dateFormatter.date(from: date)
        exchangeRate = rate
        self.currencyCode = currencyCode
    }
}
