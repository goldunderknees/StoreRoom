//
//  SRStoreRoomTestVC.swift
//  StoreRoom
//
//  Created by goldunderknees on 22/6/15.
//  Copyright © 2015 goldunderknees. All rights reserved.
//

import UIKit


///SRStoreRoomTestVC can visuallize data in storeroom. 
class SRStoreRoomTestVC: UIViewController {
    var storeRoom:SRStoreRoom?{
        didSet{
            if let store = self.storeRoom{
                loadFromStoreRoom(store)
            }
        }
    }
    
    func loadFromStoreRoom(store:SRStoreRoom){
        
    }
    
}

