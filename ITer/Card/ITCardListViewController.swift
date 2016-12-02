//
//  ITCardListViewController.swift
//  ITer
//
//  Created by salmon on 16/11/16.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit

class ITCardListViewController: ITToolBaseViewController {
    
    fileprivate var dataSource: [ITBankCard] = [ITBankCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoCardScanViewController))
        self.navigationItem.rightBarButtonItem = addButton
        CardIOUtilities.preload()
        self.tableView.register(UINib(nibName: "ITBankCardCell", bundle: Bundle.main), forCellReuseIdentifier: "ITBankCardCell")
        getBankCardList()
    }
    
    @objc fileprivate func gotoCardScanViewController() {
        let controller: CardIOPaymentViewController = CardIOPaymentViewController(paymentDelegate: self)
        controller.modalPresentationStyle = .formSheet
        controller.hideCardIOLogo = true
        self.present(controller, animated: true, completion: nil)
    }
    
    fileprivate func getBankCardList() {
        ITRealmManager.sharedInstance.getBankCardList { (bankCardList) in
            self.dataSource = bankCardList
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITBankCardCell", for: indexPath) as! ITBankCardCell
        cell.bankCardInfo = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ITBankCardCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ITCardListViewController: CardIOPaymentViewControllerDelegate {
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        ITBankCardHelper.sharedInstance.asyncGetBankCardInfoBy(cardInfo.cardNumber, completionHandler: {(bankCardInfo) in
            if bankCardInfo != nil {
                ITRealmManager.sharedInstance.addOrUpdateBankCard(bankCardInfo!, { (bankCardList) in
                    self.dataSource = bankCardList
                    self.tableView.reloadData()
                })
            } else {
                debugPrint("未能判断是哪个银行的卡")
            }
        })
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}
