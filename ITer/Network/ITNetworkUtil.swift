//
//  ITNetworkUtil.swift
//  ITer
//
//  Created by salmon on 16/11/11.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation
import Alamofire

private let DOUBAN_BOOKINFO_ISBN: String = "https://api.douban.com/v2/book/isbn/"

class ITNetworkUtil: AnyObject {

    /*
     使用豆瓣API通过isbn号获取书籍信息
     */
    class func getBookInfo(_ isbn: String, completionHandler: @escaping (_ succeed: Bool, _ result: ITBook?) -> Void) {
        let url: String = DOUBAN_BOOKINFO_ISBN + isbn
        Alamofire.request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let book = response.result.value as? [String: AnyObject] {
                        completionHandler(true, book.toITBook())
                    } else {
                        completionHandler(false, nil)
                    }
                case .failure:
                    completionHandler(false, nil)
                }
        }
    }
}
