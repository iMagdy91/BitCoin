//
//  BitcoinDetailsViewModel.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation


typealias BitcoinDetailViewModelCompletion = (BitcoinDetailUIModel?, ResponseError?) -> Void

//MARK: - Supporting Data types
 
enum RateType {
    case today
    case history
}

//MARK: - View Model

class BitcoinDetailsViewModel {
    
    //MARK: - Properties
    
    private var rateType: RateType?
    private var client: Client?
    private var bitcoinDetail: BitcoinDetailUIModel?
    private(set) var bitcoinDetailViewModelCompletion: BitcoinDetailViewModelCompletion?
    private var rateDate: Date?
    
    //MARK: - Init
    
    required init(client: Client, rateDate: Date, bitcoinDetailViewModelCompletion: @escaping BitcoinDetailViewModelCompletion) {
        self.rateDate = rateDate
        rateType = Calendar.current.isDateInToday(rateDate) ? .today : .history
        self.bitcoinDetailViewModelCompletion = bitcoinDetailViewModelCompletion
        self.client = client
        getBitcoinDetails()
    }
    
    //MARK: - Private Methods
    
    private func getBitcoinDetails() {
        if let type = rateType {
            switch type {
            case .today:
                getBitcoinCurrentRate()
            case .history:
                getBitcoinPreviousRate()
            }
        }
    }
    
    private func getBitcoinCurrentRate() {
        let _ = client?.request(BitcoinAPI.getCurrentRate(forCurrency: nil)).observe(with: { [weak self](event) in
            guard let `self` = self else { return }
            
            if let error = event.error {
                self.bitcoinDetailViewModelCompletion?(nil, error)
            }
            
            else if let bitcoinPrice = event.element {
                self.bitcoinDetail = BitcoinDetailUIModel(currentPrice: bitcoinPrice)
                self.bitcoinDetailViewModelCompletion?(self.bitcoinDetail, nil)
            }
        })
    }
    
    private func getBitcoinPreviousRate() {
        getBitcoinPreviousRate(forCurrency: "USD") { [weak self] (historyPrice) in
            guard let `self` = self else { return }
            
            self.bitcoinDetail = BitcoinDetailUIModel(historyPrice: historyPrice, date: self.rateDate, currency: "USD")
    
            self.getBitcoinPreviousRate(forCurrency: "EUR", completion: { (historyPrice) in
                self.bitcoinDetail?.appendRate(historyPrice.bpi, forCurrency: "EUR")
                
                self.getBitcoinPreviousRate(forCurrency: "GBP", completion: { (historyPrice) in
                    self.bitcoinDetail?.appendRate(historyPrice.bpi, forCurrency: "GBP")
                    self.bitcoinDetailViewModelCompletion?(self.bitcoinDetail, nil)
                })
                
            })

        }
    }
    
    private func getBitcoinPreviousRate(forCurrency currency: String, completion: @escaping (HistoryPrice) -> Void) {
        let _ = client?.request(BitcoinAPI.getRateHistory(forCurrency: currency, fromDate: rateDate ?? Date(), toDate: rateDate ?? Date())).observe(with: { [weak self] (event) in
            guard let `self` = self else { return }
            if let error = event.error {
                self.bitcoinDetailViewModelCompletion?(nil, error)
            }
            else if let bitcoinhistory = event.element {
                completion(bitcoinhistory)
            }
        })
    }
    
    

}
