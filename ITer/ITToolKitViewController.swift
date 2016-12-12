//
//  SecondViewController.swift
//  ITer
//
//  Created by salmon on 16/11/11.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class ITToolKitViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource: [ITToolItem] = [ITToolItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ITToolCell", bundle: Bundle.main), forCellReuseIdentifier: "ITToolCell")
        dataSource.append(ITToolItem("书单", "tool_booklist"))
        dataSource.append(ITToolItem("银行卡", "tool_cardlist"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FIRAnalytics.logEvent(withName: kFIREventSelectContent, parameters: [
            kFIRParameterContentType:"cont" as NSObject,
            kFIRParameterItemID:"1" as NSObject
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ITToolKitViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITToolCell", for: indexPath) as! ITToolCell
        cell.toolItem = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ITToolCellHeight
    }
}

extension ITToolKitViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let controller: ITBookListViewController = ITBookListViewController()
            controller.toolItem = dataSource[indexPath.row]
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller: ITCardListViewController = ITCardListViewController()
            controller.toolItem = dataSource[indexPath.row]
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

