//
//  ITToolItem.swift
//  ITer
//
//  Created by salmon on 16/11/12.
//  Copyright © 2016年 giv. All rights reserved.
//

import Foundation

let ITToolCellDefaultIconName: String = "tool_cell_icon_default"

class ITToolItem: AnyObject {
    
    // 工具名称
    var toolName: String = ""
    
    // 工具Icon 可以是URL，也可以是ImageName，如果是URL必须以http开头
    var toolIcon: String = ""
    
    init(_ name: String, _ icon: String?) {
        toolName = name
        if icon != nil {
            toolIcon = icon!
        } else {
            toolIcon = ITToolCellDefaultIconName
        }
    }
    
}
