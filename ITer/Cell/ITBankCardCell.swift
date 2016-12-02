//
//  ITBankCardCell.swift
//  ITer
//
//  Created by salmon on 16/11/17.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit

let ITBankCardCellHeight: CGFloat = 150

class ITBankCardCell: UITableViewCell {
    
    var bankCardInfo: ITBankCard! {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTypeDesLabel: UILabel!
    
    fileprivate func updateCell() {
        cardNumberLabel.text = bankCardInfo.cardNumber
        cardTypeDesLabel.text = ITBankCard.cardTypeDescription(bankCardInfo.cardType)
        bankNameLabel.text = bankCardInfo.bankName
    }
}
