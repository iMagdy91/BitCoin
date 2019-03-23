//
//  BitcoinWidgetViewModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation

typealias BitcoinWidgetViewModelCompletion = (BitcoinRate?, ResponseError?) -> Void


class BitcoinWidgetViewModel: TimeBasedViewModel {
    
    
    //MARK: - Properties
    
    private var client: Client?
    private var bitcoinRate: BitcoinRate?
    private(set) var bitcoinWidgetViewModelCompletion: BitcoinWidgetViewModelCompletion?
    private let updateTime = 10.0

    
    //MARK: Init
    
    required init(client: Client, completion: @escaping BitcoinWidgetViewModelCompletion) {
        super.init()
        self.bitcoinWidgetViewModelCompletion = completion
        self.client = client
        getBitcoinRate()
    }
    
    private func getBitcoinRate() {
        stopTimer()
        getBitcoinRateUpdates()
        timer = Timer.scheduledTimer(withTimeInterval: updateTime, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            self.getBitcoinRateUpdates()
        }
    }
    
    private func getBitcoinRateUpdates() {
        let _ = client?.request(BitcoinAPI.getCurrentRate(forCurrency: "EUR")).observe(with: { [weak self] (event) in
            guard let `self` = self else { return }
            
            if let error = event.error {
                self.bitcoinWidgetViewModelCompletion?(nil, error)
            }
                
            else if let currentPrice = event.element {
                self.bitcoinRate = BitcoinRate(currencyCode: "EUR", rate: currentPrice.bpi["EUR"]?.rate_float)
                self.bitcoinWidgetViewModelCompletion?(self.bitcoinRate, nil)
            }
        })
    }
}
