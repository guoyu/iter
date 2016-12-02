//
//  ITBankCardHelper.swift
//  ITer
//
//  Created by salmon on 16/11/17.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation

class ITBankPattern: AnyObject {
    var cardType: String = ""
    var reg: String = ""
    
    init(dict: [String: Any]) {
        if let reg: String = dict["reg"] as? String {
            self.reg = reg
        }
        if let cardType: String = dict["cardType"] as? String {
            self.cardType = cardType
        }
    }
    
    func match(_ bankNumber: String) -> Bool {
        return ITRegex(reg).match(bankNumber)
    }
}

class ITBankInfo: AnyObject {
    var bankName: String = ""
    var bankCode: String = ""
    var patterns: [ITBankPattern] = [ITBankPattern]()
    
    init(dict: [String: Any]) {
        if let bankName: String = dict["bankName"] as? String {
            self.bankName = bankName
        }
        if let bankCode: String = dict["bankCode"] as? String {
            self.bankCode = bankCode
        }
        if let patterns: [[String: Any]] = dict["patterns"] as? [[String: Any]] {
            for pattern in patterns {
                self.patterns.append(ITBankPattern(dict: pattern))
            }
        }
    }
}

class ITBankCardHelper: AnyObject {
    
    static let sharedInstance = ITBankCardHelper()
    
    fileprivate let queue: DispatchQueue = DispatchQueue(label: "iter.bank.card.helper")
    fileprivate var bankInfoList: [ITBankInfo] = [ITBankInfo]()
    
    init() {
        queue.async {
            if let data: Data = NSDataAsset(name: "bankCard")?.data {
                if let json = try? JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [[String: Any]] {
                    for item in json {
                        self.bankInfoList.append(ITBankInfo(dict: item))
                    }
                }
            }
        }
    }
    
    func asyncGetBankCardInfoBy(_ cardNumber: String, completionHandler: @escaping (_ bankCardInfo: ITBankCard?) -> Void) {
        queue.async { 
            for bankInfo in self.bankInfoList {
                if bankInfo.patterns.count > 0 {
                    for pattern in bankInfo.patterns {
                        if pattern.match(cardNumber) {
                            let bankCardInfo: ITBankCard = ITBankCard()
                            bankCardInfo.bankCode = bankInfo.bankCode
                            bankCardInfo.bankName = bankInfo.bankName
                            bankCardInfo.cardNumber = cardNumber
                            bankCardInfo.cardType = pattern.cardType
                            DispatchQueue.main.async(execute: { 
                                completionHandler(bankCardInfo)
                            })
                            return
                        }
                    }
                }
            }
            DispatchQueue.main.async(execute: {
                completionHandler(nil)
            })
        }
    }
}
