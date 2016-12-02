//
//  ITToolCell.swift
//  ITer
//
//  Created by salmon on 16/11/12.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import SDWebImage

let ITToolCellHeight: CGFloat = 60

class ITToolCell: UITableViewCell {
    
    var toolItem: ITToolItem! {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var toolImageView: UIImageView!
    @IBOutlet weak var toolNameLabel: UILabel!
    
    fileprivate func updateCell() {
        if toolItem.toolIcon.isUrl() {
            toolImageView.sd_setImage(with: URL(string: toolItem.toolIcon), placeholderImage: UIImage(named: ITToolCellDefaultIconName))
        } else {
            toolImageView.image = UIImage(named: toolItem.toolIcon)
        }
        toolNameLabel.text = toolItem.toolName
    }
}
