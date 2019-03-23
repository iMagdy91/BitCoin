//
//  BitcoinRateHistoryViewController.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import UIKit

class BitcoinRateHistoryViewController: UIViewController {

    //MARK: - Properties
    
    private var bitcoinRateList: [BitcoinListUIModel]? {
        didSet {
            tableview.reloadData()
        }
    }
    private var bitcoinRateViewModel: BitcoinListViewModel?
    
    //MARK: - Outlets
    
    @IBOutlet private weak var tableview: UITableView! {
        didSet {
            tableview.rowHeight = UITableView.automaticDimension
            tableview.estimatedRowHeight = 44.0
            tableview.tableFooterView = UIView()
        }
    }
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        bitcoinRateViewModel = BitcoinListViewModel(client: HttpClient(), completion: { [weak self] (modelList, responseError) in
            guard let `self` = self else { return }
            if let error = responseError {
                self.showMessage(error.reason)
            }
            else if let model = modelList {
                self.bitcoinRateList = model
            }
        })
    }
    
}

extension BitcoinRateHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoinRateList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: BitcoinHistoryTableViewCell.cellIdentifier) as? BitcoinHistoryTableViewCell
        
        cell?.configureCell(withUIModel: bitcoinRateList?[indexPath.row])
        
        return cell!
    }
    
    //MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.goToBitcoinRateDetails, sender: indexPath)
    }
    
    
}

extension BitcoinRateHistoryViewController {
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bitcoinDetailViewController = segue.destination as? BitcoinRateDetailViewController, let indexPath = sender as? IndexPath {
            bitcoinDetailViewController.rateDate = bitcoinRateList?[indexPath.row].rateDate
        }
    }
    
}
