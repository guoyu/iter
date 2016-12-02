//
//  ITBook.swift
//  ITer
//
//  Created by salmon on 16/11/11.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation
import RealmSwift

/*
 Realm不能存储[String]，List<Class>里Class必须为Object，需要转一次
 */
class RealmString: Object {
    dynamic var stringValue = ""
}

/*
 根据豆瓣返回书籍数据结构创建,详细可以参见: https://developers.douban.com/wiki/?title=book_v2#get_isbn_book
 */
class ITBook: Object {
    
    // 豆瓣BookInfo的唯一标识
    dynamic var id: String              = ""
    
    // 书名
    dynamic var title: String           = ""
    
    // 书籍原名,可能是外文书籍
    dynamic var originTitle: String     = ""
    
    // 书籍简介
    dynamic var summary: String         = ""
    
    // 作者，可能是多位
    var author: [String] {
        get {
            return _backingAuthors.map { $0.stringValue }
        }
        set {
            _backingAuthors.removeAll()
            _backingAuthors.append(objectsIn: newValue.map { RealmString(value: [$0]) })
        }
    }
    let _backingAuthors = List<RealmString>()
    
    // 作者简介
    dynamic var authorIntro: String     = ""
    
    // 译者，可能是多位
    var translator: [String] {
        get {
            return _backingTranslators.map { $0.stringValue }
        }
        set {
            _backingTranslators.removeAll()
            _backingTranslators.append(objectsIn: newValue.map { RealmString(value: [$0]) })
        }
    }
    let _backingTranslators = List<RealmString>()
    
    // 出版商
    dynamic var publisher: String       = ""
    
    // 书籍图片,中等大小
    dynamic var image: String           = ""
    
    // 书籍大图
    dynamic var largeImage: String      = ""
    
    // isbn号详细介绍可以参见: https://zh.wikipedia.org/wiki/%E5%9B%BD%E9%99%85%E6%A0%87%E5%87%86%E4%B9%A6%E5%8F%B7
    dynamic var isbn10: String          = ""
    dynamic var isbn13: String          = ""
    
    // 豆瓣打分
    dynamic var rating: String          = "未知"
    
    // 书价
    dynamic var price: String           = ""
    
    // 出版时间
    dynamic var pubdate: String         = ""
    
    // 创建时间
    dynamic var creationDate: NSDate       = NSDate()

    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["creationDate"]
    }
    
    override static func ignoredProperties() -> [String] {
        return ["author", "translator"]
    }
}
