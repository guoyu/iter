//
//  ITBookDetailsViewController.swift
//  ITer
//
//  Created by salmon on 16/11/15.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit

class ITBookDetailsViewController: UITableViewController {
    
    var bookInfo: ITBook!
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "ITBookDetailsCell", bundle: Bundle.main), forCellReuseIdentifier: "ITBookDetailsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITBookDetailsCell", for: indexPath) as! ITBookDetailsCell
        cell.bookInfo = bookInfo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ITBookDetailsCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

