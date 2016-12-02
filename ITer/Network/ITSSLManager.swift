//
//  ITSSLManager.swift
//  ITer
//
//  Created by salmon on 16/11/29.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation
import Alamofire

let DEVICELIST_URL = "https://miwifi.com/cgi-bin/luci/;stok=d446ccbc101acdfb91f45afc57ffac8c/api/misystem/devicelist"

class ITSSLManager: AnyObject {
    
    static let sharedInstance: ITSSLManager = ITSSLManager()
    
    private var manager: SessionManager!
    
    init() {
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: ServerTrustPolicy.certificates(),
            validateCertificateChain: true,
            validateHost: true
        )
        let serverTrustPolicies: [String : ServerTrustPolicy] = ["miwifi.com": serverTrustPolicy]
        manager = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
    
    func getDeviceList() {
        manager.request(DEVICELIST_URL, method: .get, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    debugPrint("111111")
                case .failure:
                    debugPrint("222222")
                }
        }
    }
}
