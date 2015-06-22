//
//  SRManageItem.swift
//  StoreRoom
//
//  Created by goldunderknees on 22/6/15.
//  Copyright © 2015 goldunderknees. All rights reserved.
//

import Foundation

public protocol SRManageItem{
    var uniqueID:String {get set}
    static func itemClass() -> String
    init (byStore:SRStoreRoomManage)
    func toSavable()->[String:SRSavable]
    init (fromSavable values:[String:SRSavable])
}