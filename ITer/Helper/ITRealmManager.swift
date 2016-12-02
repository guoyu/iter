//
//  ITRealmManager.swift
//  ITer
//
//  Created by salmon on 16/11/15.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation
import RealmSwift

/*
 请在UI线程使用
 */
class ITRealmManager: AnyObject {
    
    static let sharedInstance = ITRealmManager()
    
    fileprivate var realm: Realm!
    
    init() {
        self.realm = try! Realm()
    }
    
    func addOrUpdateBook(_ book: ITBook, _ completionHandler: @escaping (_ books: [ITBook]) -> Void) {
        try! self.realm.write {
            self.realm.add(book, update: true)
        }
        let list: [ITBook] = Array(self.realm.objects(ITBook.self).sorted(byProperty: "creationDate"))
        completionHandler(list)
    }
    
    func getBookList(_ completionHandler: @escaping (_ books: [ITBook]) -> Void) {
        let list: [ITBook] = Array(self.realm.objects(ITBook.self).sorted(byProperty: "creationDate"))
        completionHandler(list)
    }
    
    func addOrUpdateBankCard(_ card: ITBankCard, _ completionHandler: @escaping (_ books: [ITBankCard]) -> Void) {
        try! self.realm.write {
            self.realm.add(card, update: true)
        }
        let list: [ITBankCard] = Array(self.realm.objects(ITBankCard.self).sorted(byProperty: "creationDate"))
        completionHandler(list)
    }
    
    func getBankCardList(_ completionHandler: @escaping (_ books: [ITBankCard]) -> Void) {
        let list: [ITBankCard] = Array(self.realm.objects(ITBankCard.self).sorted(byProperty: "creationDate"))
        completionHandler(list)
    }
}
