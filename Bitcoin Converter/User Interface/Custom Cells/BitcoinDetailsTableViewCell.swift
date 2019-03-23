//
//  BitcoinDetailsTableViewCell.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 23.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import UIKit

class BitcoinDetailsTableViewCell: UITableViewCell {

    //MARK: - Cell Identifier
    
    static let cellIdentifier = "BitcoinDetailsTableViewCell"

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    //MARK: - Cell Configuration
    
    func configureCell(withUIModel model: BitcoinRate?, forDate date: Date?) {
        selectionStyle = .none

        currencyLabel.text = model?.currencyCode
        rateLabel.text = String(model?.rate ?? 0)
    }
}
