//
//  ITUtil.swift
//  ITer
//
//  Created by salmon on 16/11/14.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation

// 邮箱验证
let ITMailPattern: String = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"

// IP地址验证
let ITIPPattern: String   = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

// 用户名验证（允许使用大小写字母、数字、下滑线、横杠，一共8~16个字符
let ITUserNamePattern: String = "^[a-zA-Z0-9_-]{8,16}$"

struct ITRegex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern,
                                         options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                                options: [],
                                                range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}

/*
 String extension
 */
extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func isUrl() -> Bool {
        do {
            let dataDetector: NSDataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            let res = dataDetector.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            if res.count == 1  && res[0].range.location == 0
                && res[0].range.length == self.characters.count {
                return true
            }
        }
        catch {
            return false
        }
        return false
    }
    
    func isMail() -> Bool {
        return ITRegex(ITMailPattern).match(self)
    }
    
    func isIP() -> Bool {
        return ITRegex(ITIPPattern).match(self)
    }
    
    func isUserName() -> Bool {
        return ITRegex(ITUserNamePattern).match(self)
    }
    
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    func toITBook() -> ITBook {
        let book: ITBook = ITBook()
        if let id: String = self["id"] as? String {
            book.id = id
        }
        if let title: String = self["title"] as? String {
            book.title = title
        }
        if let originTitle: String = self["origin_title"] as? String {
            book.originTitle = originTitle
        }
        if let summary: String = self["summary"] as? String {
            book.summary = summary
        }
        if let author: [String] = self["author"] as? [String] {
            book.author = author
        }
        if let authorIntro: String = self["author_intro"] as? String {
            book.authorIntro = authorIntro
        }
        if let translator: [String] = self["translator"] as? [String] {
            book.translator = translator
        }
        if let publisher: String = self["publisher"] as? String {
            book.publisher = publisher
        }
        if let image: String = self["image"] as? String {
            book.image = image
        }
        if let images: [String: String] = self["images"] as? [String: String] {
            if let limage: String = images["large"] {
                book.largeImage = limage
            } else {
                book.largeImage = book.image
            }
        }
        if let isbn10: String = self["isbn10"] as? String {
            book.isbn10 = isbn10
        }
        if let isbn13: String = self["isbn13"] as? String {
            book.isbn13 = isbn13
        }
        if let pubdate: String = self["pubdate"] as? String {
            book.pubdate = pubdate
        }
        if let price: String = self["price"] as? String {
            book.price = price
        }
        if let rating: [String: AnyObject] = self["rating"] as? [String: AnyObject] {
            if let average: String = rating["average"] as? String {
                book.rating = average
            }
        }
        return book
    }
}
