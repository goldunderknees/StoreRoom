//
//  SRStoreRoom.swift
//  StoreRoom
//
//  Created by Kin Lui on 22/6/15.
//  Copyright © 2015 goldunderknees. All rights reserved.
//

import Foundation

enum SRStoreIOError:ErrorType{
    case StoreRoomNotFind
    case StoreRoomCantBeCreated
}

class SRStoreRoom:SRStoreRoomManage {
    
    var savingCacheNumber:Int = 100
    var chacheNumber:Int = 300
    
    var storeRoomID:String
    var toSaveChache:[[String:SRSavable]] = []
    var uniqueIDGenerator:SRItemIDGenerator
    
    required init(storeRoomID: String,itemIDGenerator:SRItemIDGenerator) throws {
        self.storeRoomID = storeRoomID
        self.uniqueIDGenerator = itemIDGenerator
        do {
            var path = try storeRoomPath(storeRoomID)
            
        }catch SRStoreIOError.StoreRoomCantBeCreated{
            fatalError("StoreRoomCantBeCreated")
        }catch SRStoreIOError.StoreRoomNotFind{
            fatalError("Cant find exiting StoreRoom")
        }
    }
    
    func addItem<T where T:SRManageItem>(item: T) {
        var values = item.toSavable()
        values["itemClass"] =  T.itemClass()
        values["uniqueID"] = item.uniqueID
        for (index,anItem) in toSaveChache.enumerate(){
            if let uniqueID = anItem["uniqueID"] as? String where
                uniqueID == item.uniqueID{
                    toSaveChache[index] = values
                    return
            }
        }
        toSaveChache.append(values)
    }
    
    func removeItem<T where T:SRManageItem>(item: T) {
        
    }
    
    func addItems<T where T:SRManageItem>(items: [T]) {
        for item in items{
            addItem(item)
        }
    }
    
    func removeItems<T where T:SRManageItem>(items: [T]) {
        for item in items{
            removeItem(item)
        }
    }
    
    func save(async:Bool){
        if !async{
            saveToDisk()
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            self.saveToDisk()
        }
    }
    
    internal func saveToDisk(){
        
    }
    
    internal func storeRoomPath(withID:String) throws ->  NSURL{
        var fileManager = NSFileManager.defaultManager()
        var urlPaths = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)

        return NSURL()
    }
    
}