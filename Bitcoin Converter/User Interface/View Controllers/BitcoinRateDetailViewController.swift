//
//  BitcoinRateDetailViewController.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import UIKit

class BitcoinRateDetailViewController: UIViewController {

    
    //MARK: - Properties
    
    var rateDate: Date? {
        didSet {
            getData()
        }
    }
    private var bitcoinDetailViewModel: BitcoinDetailsViewModel?
    private var bitCoinRateDetail: BitcoinDetailUIModel? {
        didSet {
            tableview.reloadData()
        }
    }
    private var dateFormatter = DateFormatter()
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.rowHeight = UITableView.automaticDimension
            tableview.estimatedRowHeight = 44.0
            tableview.tableFooterView = UIView()        }
    }
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd-MMMM-yyyy"
        self.title = dateFormatter.string(from: rateDate ?? Date())
    }
    
    //MARK: - Private Methods
    
    private func getData() {
        bitcoinDetailViewModel = BitcoinDetailsViewModel(client: HttpClient(), rateDate: rateDate ?? Date(), bitcoinDetailViewModelCompletion: { (bitCoinDetailUIModel, responseError) in
            if let error = responseError {
                self.showMessage(error.reason)
            }
            else if let model = bitCoinDetailUIModel {
                self.bitCoinRateDetail = model
            }
        })
    }
    

}

extension BitcoinRateDetailViewController: UITableViewDataSource {
    
    //MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitCoinRateDetail?.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: BitcoinDetailsTableViewCell.cellIdentifier) as? BitcoinDetailsTableViewCell
        
        cell?.configureCell(withUIModel: bitCoinRateDetail?.rates?[indexPath.row], forDate: bitCoinRateDetail?.rateDate)
        
        return cell!
    }
    
}
