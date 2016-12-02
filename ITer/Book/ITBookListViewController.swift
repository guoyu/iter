//
//  ITBookListViewController.swift
//  ITer
//
//  Created by salmon on 16/11/15.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import RealmSwift

class ITBookListViewController: ITToolBaseViewController {
    
    fileprivate var dataSource: [ITBook] = [ITBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoScanViewController))
        self.navigationItem.rightBarButtonItem = addButton
        self.tableView.register(UINib(nibName: "ITBookCell", bundle: Bundle.main), forCellReuseIdentifier: "ITBookCell")
        getBookList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITBookCell", for: indexPath) as! ITBookCell
        cell.bookInfo = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ITBookCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller: ITBookDetailsViewController = ITBookDetailsViewController()
        controller.bookInfo = dataSource[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc fileprivate func gotoScanViewController() {
        let scanViewController: ITBarCodeScanViewController = ITBarCodeScanViewController()
        scanViewController.delegate = self
        self.navigationController?.pushViewController(scanViewController, animated: true)
    }
    
    fileprivate func getBookList() {
        ITRealmManager.sharedInstance.getBookList { (books) in
            self.dataSource = books
            self.tableView.reloadData()
        }
    }
}

extension ITBookListViewController: ITScanDelegate {
    func succeedWithCodeString(_ str: String) {
        ITNetworkUtil.getBookInfo(str, completionHandler: {(succeed, book) in
            if succeed {
                ITRealmManager.sharedInstance.addOrUpdateBook(book!, { (books) in
                    self.dataSource = books
                    self.tableView.reloadData()
                })
            }
        })
    }
}
