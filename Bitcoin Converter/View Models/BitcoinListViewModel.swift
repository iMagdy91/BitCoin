//
//  BitcoinListViewModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import EVReflection
import Bond

typealias BitcoinListViewModelCompletion = ([BitcoinListUIModel]?, ResponseError?) -> Void

//MARK: - Supporting Data types

enum CurrencyCode: String {
    case euro = "EUR"
    case usDollar = "USD"
    case britishPound = "GBP"
}

private let currentValueUpdateTimeInSeconds = 60.0
let currency: CurrencyCode = .euro

//MARK: - View Model

class BitcoinListViewModel: TimeBasedViewModel {
    
    //MARK: - Properties
    
    private var client: Client?
    private var bitcoinHistoryList = [BitcoinListUIModel]()
    private(set) var bitcoinListViewModelCompletion: BitcoinListViewModelCompletion?
    
    //MARK: - Init
    
    required init(client: Client, completion: @escaping BitcoinListViewModelCompletion) {
        super.init()
        self.bitcoinListViewModelCompletion = completion
        self.client = client
        getBitCoinHistory()
    }
    
    
    
    //MARK: - View Model Logic Methods
    
    private func getBitCoinHistory() {
        stopTimer()
        getBitcoinHistoryUpdates()
        timer = Timer.scheduledTimer(withTimeInterval: currentValueUpdateTimeInSeconds, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            self.getBitcoinHistoryUpdates()
        }
    }
    
    private func getBitcoinHistoryUpdates() {
        let _ = self.client?.request(BitcoinAPI.getCurrentRate(forCurrency: currency.rawValue)).observe(with: {[weak self](event) in
            guard let `self` = self else { return }
            
            if let error = event.error {
                self.bitcoinListViewModelCompletion?(nil, error)
            }
            else if let bitcoinPrice = event.element {
                if self.bitcoinHistoryList.count >= 1 {
                    self.bitcoinHistoryList.remove(at: 0)
                }
                self.bitcoinHistoryList.insert(BitcoinListUIModel(currentPrice: bitcoinPrice), at: 0)
                
                //Only calls the history API if the values are not there
                if self.bitcoinHistoryList.count == 1 {
                    let _ = self.client?.request(BitcoinAPI.getRateHistory(forCurrency: currency.rawValue, fromDate: Date().daysAgo(days: 14), toDate: Date.yesterday)).observe(with: { (event) in
                        if let error = event.error {
                            self.bitcoinListViewModelCompletion?(nil, error)
                        }
                        else if let bitcoinHistory = event.element {
                            bitcoinHistory.bpi.forEach({
                                self.bitcoinHistoryList.append(BitcoinListUIModel(date: $0.key, rate: $0.value, currencyCode: currency.rawValue))
                            })
                            
                            self.bitcoinHistoryList = self.bitcoinHistoryList.sorted(by: {($0.rateDate ?? Date()).compare($1.rateDate ?? Date()) == .orderedDescending})
                            self.bitcoinListViewModelCompletion?(self.bitcoinHistoryList, nil)
                        }
                    })
                }
                else {
                    self.bitcoinListViewModelCompletion?(self.bitcoinHistoryList, nil)
                }
                
            }
            
        })
    }
    
}
