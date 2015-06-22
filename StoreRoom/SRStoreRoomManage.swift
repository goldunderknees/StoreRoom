//
//  SRStoreRoomManage.swift
//  StoreRoom
//
//  Created by goldunderknees on 21/6/15.
//  Copyright (c) 2015 goldunderknees. All rights reserved.
//

import Foundation

//TODO : Should re-think objectID generate machanism, combine generate and parse function to improve finding speed and enable paging system of store room.
public typealias SRItemIDGenerator = (item:SRManageItem) -> String


//TODO : Consider Low Level store method between using sqlLite or writing set.
public protocol SRStoreRoomManage{
    
    var savingCacheNumber:Int {get set}
    var chacheNumber:Int {get set}
    // To enable paging, above property
    // may be replaced with
    // var maximumDataPerPage:Int {get set}
    // var currentPage:Int {get set}
    
    var toSaveChache:[[String:SRSavable]] {get set}
    /// initial a storeroom. represent the storeroom(Storeroom name on disk is not always reponsible to be the same) and use to generate itemID
    var storeRoomID:String {get set}
    
    init(storeRoomID:String,itemIDGenerator:SRItemIDGenerator) throws
    
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
    
    //TODO : Consider to initialize data class by SRStoreRoom when relationship of reference object to write should not make user to worry about. ***Not to use ObjC-runtime
    //func registerItemClass<T where T:SRManageItem>(T)
}


