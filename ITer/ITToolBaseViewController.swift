//
//  ITToolBaseViewController.swift
//  ITer
//
//  Created by salmon on 16/11/16.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit

class ITToolBaseViewController: UITableViewController {
    
    var toolItem: ITToolItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = toolItem.toolName
    }
}
