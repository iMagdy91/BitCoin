//
//  Bitcoin_ConverterTests.swift
//  Bitcoin ConverterTests
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import XCTest
@testable import Bitcoin_Converter

class Bitcoin_ConverterTests: XCTestCase {
    
    var bitcoinListViewModel: BitcoinListViewModel?
    var bitcoinDetailViewModel: BitcoinDetailsViewModel?
    
    override func setUp() {
        
    }

    override func tearDown() {
    }

    func testHistoryList() {
        let expectation = self.expectation(description: "BitcoinList")
        //For ideal scenarios, use mock Client
        bitcoinListViewModel = BitcoinListViewModel(client: HttpClient(), completion: { (bitcoinList, error) in
            XCTAssertNil(error)
            XCTAssert(bitcoinList?.count == 15)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRateDetail() {
        let expectation = self.expectation(description: "BitcoinDetail")
        //For ideal scenarios, use mock Client
        bitcoinDetailViewModel = BitcoinDetailsViewModel(client: HttpClient(), rateDate: Date(), bitcoinDetailViewModelCompletion: { (bitcoinDetailModel, error) in
            XCTAssertNil(error)
            XCTAssert(Calendar.current.isDateInToday(bitcoinDetailModel?.rateDate ?? Date.yesterday))
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10.0, handler: nil)

    }



}
