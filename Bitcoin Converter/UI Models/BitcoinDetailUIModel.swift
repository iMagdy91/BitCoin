//
//  BitcoinDetailUIModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation

class BitcoinDetailUIModel {
    
    //MARK: - Properties
    
    private(set) var rateDate: Date?
    private(set) var rates: [BitcoinRate]?
    
    //MARK: - Init
    
    init(currentPrice: CurrentPrice) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        rateDate = dateFormatter.date(from: currentPrice.time?.updatedISO ?? "")
        rates = [BitcoinRate]()
        currentPrice.bpi.forEach { [weak self] (key, value) in
            self?.rates?.append(BitcoinRate(currencyCode: value.code, rate: value.rate_float))
        }
    }
    
    init(historyPrice: HistoryPrice, date: Date?, currency: String) {
        self.rateDate = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date ?? Date())
        rates = [BitcoinRate(currencyCode: currency, rate: historyPrice.bpi[dateString])]
        
    }
    
    func appendRate(_ rate: [String : Double], forCurrency currency: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self.rateDate ?? Date())
        rates?.append(BitcoinRate(currencyCode: currency, rate: rate[dateString]))
    }
}

class BitcoinRate {
    
    private(set) var currencyCode: String?
    private(set) var rate: Double?
    
    init(currencyCode: String?, rate: Double?) {
        self.currencyCode = currencyCode
        self.rate = rate
    }
}

