//
//  ITBookCell.swift
//  ITer
//
//  Created by salmon on 16/11/15.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import SDWebImage

let ITBookCellHeight: CGFloat = 80

class ITBookCell: UITableViewCell {
    
    var bookInfo: ITBook! {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    fileprivate func updateCell() {
        bookCover.sd_setImage(with: URL(string: bookInfo.image), placeholderImage: UIImage(named: "cell_book_cover_default"))
        bookNameLabel.text = bookInfo.title
        bookAuthorLabel.text = bookInfo.author.joined(separator: ",")
    }
    
}
