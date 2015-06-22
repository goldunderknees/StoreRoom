//: Playground - noun: a place where people can play

import UIKit

class SRStoreRoom:SRStoreRoomManage {
    
    var savingCacheNumber:Int = 100
    var chacheNumber:Int = 300
    
    var storeRoomID:String
    var toSaveChache:[[String:SRSavable]] = []
    var uniqueIDGenerator:SRItemIDGenerator
    
    required init(storeRoomID: String,itemIDGenerator:SRItemIDGenerator) {
        self.storeRoomID = storeRoomID
        self.uniqueIDGenerator = itemIDGenerator
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
    
}

class MyItem:SRManageItem{
    
    var uniqueID:String = ""
        
    static func itemClass() -> String {
        return "MyItem"
    }
    
    var myName:String?
    var myAge:Float?
    
    required init (byStore:SRStoreRoomManage){
        uniqueID = byStore.uniqueIDGenerator(item: self)
    }

    required init(fromSavable values: [String : SRSavable]) {
        self.uniqueID = values["uniqueID"] as! String
        self.myName = values["myName"] as? String
        self.myAge = values["myAge"] as? Float
        
    }
    
    func toSavable() -> [String : SRSavable] {
        var toSave:[String:SRSavable] = [String:SRSavable]()
        
        if let name = self.myName{
            toSave["myName"] = name
        }

        if let age = self.myAge {
            toSave["myAge"] = age
        }

        return toSave
    }
    
}

var myStore = SRStoreRoom(storeRoomID: "myStore") { (item) -> String in
    var dateFormater = NSDateFormatter()
    dateFormater.formatterBehavior = NSDateFormatter.defaultFormatterBehavior()
    
    dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormater.dateFormat
    var dateStamp = dateFormater.stringFromDate(NSDate())
    return "myStore" + dateStamp + "\(rand()%16)"
}

//Test to save Item
var item1 = MyItem(byStore: myStore)
item1.uniqueID
item1.myName = "Hello you"

myStore.addItem(item1)

myStore.toSaveChache

if let itemData = myStore.toSaveChache.first{
    var item2 = MyItem(fromSavable: itemData)
    item2.myName = "damn"
    item2.myAge = 14
    myStore.addItem(item2)
    myStore.toSaveChache
}
item1.myAge = 15
myStore.addItem(item1)
myStore.toSaveChache
var item2 = MyItem(byStore: myStore)
item2.myName = "Hell"
item2.myAge = 12
myStore.addItem(item2)
myStore.toSaveChache




