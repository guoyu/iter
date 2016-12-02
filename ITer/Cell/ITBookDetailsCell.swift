//
//  ITBookDetailsCell.swift
//  ITer
//
//  Created by salmon on 16/11/15.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import SDWebImage

let ITBookDetailsCellHeight: CGFloat = 200

class ITBookDetailsCell: UITableViewCell {
    
    var bookInfo: ITBook! {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookTranslatorLabel: UILabel!
    @IBOutlet weak var bookPublishInfoLabel: UILabel!
    
    fileprivate func updateCell() {
        bookCover.sd_setImage(with: URL(string: bookInfo.largeImage), placeholderImage: UIImage(named: "cell_book_cover_default"))
        bookNameLabel.text = bookInfo.title
        bookAuthorLabel.text = bookInfo.author.joined(separator: ",")
        bookTranslatorLabel.text = bookInfo.translator.joined(separator: ",")
        bookPublishInfoLabel.text = bookInfo.publisher + "/" + bookInfo.pubdate
    }
}
