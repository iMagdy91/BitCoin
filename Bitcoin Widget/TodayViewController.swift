//
//  TodayViewController.swift
//  Bitcoin Widget
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //MARK: - Outlets
    
    @IBOutlet weak var rateLabel: UILabel!
    
    //MARK: - Properties
    
    private var viewModel: BitcoinWidgetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .compact
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        viewModel = BitcoinWidgetViewModel.init(client: HttpClient(), completion: { [weak self] (bitCoinRate, responseError) in
            guard let `self` = self else { return }
            if let _ = responseError {
                completionHandler(NCUpdateResult.failed)
            }
            else if let rate = bitCoinRate {
                self.rateLabel.text = "EUR \(rate.rate ?? 0)"
                completionHandler(NCUpdateResult.newData)
            }
        })
        
    }
    
}
