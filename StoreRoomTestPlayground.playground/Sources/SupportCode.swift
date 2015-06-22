//
// This file (and all other Swift source files in the Sources directory of this playground) will be precompiled into a framework which is automatically made available to StoreRoomTestPlayground.playground.
//

import Foundation


/// PlaceHolder Protocol to represent whether Items are savable
public protocol SRSavable{
    
}

extension String:SRSavable{
    
}

extension Int64:SRSavable{
    
}

extension Float:SRSavable{
    
}

extension NSDate:SRSavable{
    
}

extension NSData:SRSavable{
    
}

public typealias SRItemIDGenerator = (item:SRManageItem) -> String


public protocol SRStoreRoomManage{
    
    var savingCacheNumber:Int {get set}
    var chacheNumber:Int {get set}
    
    var toSaveChache:[[String:SRSavable]] {get set}
    /// initial a storeroom. represent the storeroom(Storeroom name on disk is not always reponsible to be the same) and use to generate itemID
    var storeRoomID:String {get set}
    
    init(storeRoomID:String,itemIDGenerator:SRItemIDGenerator)
    
    /// use to generate an unique ObjectID  when storing an item
    var uniqueIDGenerator : SRItemIDGenerator {get set}
    
    ///add item to store room, will write to disk every timecyle.
    func addItem<T where T:SRManageItem>(item: T)
    
    ///remove item from store room immediatly.
    func removeItem<T where T:SRManageItem>(item: T)
    
    ///add items to store room, will write to disk every timecyle.
    func addItems<T where T:SRManageItem>(items: [T])
    
    ///add items from store room immediatly.
    func removeItems<T where T:SRManageItem>(items: [T])
    
    func save(async:Bool)
    
}

public protocol SRManageItem{
    var uniqueID:String {get set}
    static func itemClass() -> String
    init (byStore:SRStoreRoomManage)
    func toSavable()->[String:SRSavable]
    init (fromSavable values:[String:SRSavable])
}