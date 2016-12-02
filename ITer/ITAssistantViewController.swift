//
//  FirstViewController.swift
//  ITer
//
//  Created by salmon on 16/11/11.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit

class ITAssistantViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ITSSLManager.sharedInstance.getDeviceList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
