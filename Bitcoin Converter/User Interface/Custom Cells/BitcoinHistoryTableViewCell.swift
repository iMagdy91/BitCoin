//
//  BitcoinHistoryTableViewCell.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 21.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import UIKit

class BitcoinHistoryTableViewCell: UITableViewCell {

    //MARK: - Cell Identifier
    
    static let cellIdentifier = "BitcoinHistoryTableViewCell"

    //MARK: - Outlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    //MARK: - Cell Configuration
    
    func configureCell(withUIModel model: BitcoinListUIModel?) {
        selectionStyle = .none
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateLabel.text = dateFormatter.string(from: model?.rateDate ?? Date())
        rateLabel.text = "\(currency.rawValue) \(model?.exchangeRate ?? 0.0)"
    }
    
}
