//
//  ITBankCard.swift
//  ITer
//
//  Created by salmon on 16/11/16.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation
import RealmSwift

class ITBankCard: Object {

    dynamic var cardNumber: String = ""
    
    dynamic var bankName: String = ""

    dynamic var bankCode: String = ""
    
    dynamic var cardType: String = ""
    
    dynamic var cardValidDate: String = ""
    
    //Card Security Code
    dynamic var cardCSC: String = ""
    
    dynamic var creationDate: NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "cardNumber"
    }
    
    override static func indexedProperties() -> [String] {
        return ["creationDate"]
    }
    
    class func cardTypeDescription(_ cardType: String) -> String? {
        let dict = [
            "DC": "储蓄卡",
            "CC": "信用卡",
            "SCC": "准贷记卡",
            "PC": "预付费卡"
        ]
        return dict[cardType]
    }
}
