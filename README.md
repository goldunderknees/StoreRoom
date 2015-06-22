# StoreRoom
iOS local NoSQL DB - in constuction

***Don't use in your project because StoreRoom has not finished yet!

StoreRoom basic structure

#Basic structure:
##protocols defined:
SRStoreRoomManage --- define a basic io api, let user construc their own data manager in future

SRManageItem --- protocol to conform for custome data class

SRSavable --- placeholder for ensure type is writable value to disk. /// All data can serialize into NSData then to save.

SRRefrencable --- protocol to support referencing other data-class 


##classes defined:
SRStoreRoom --- class conform to SRStoreManage, default class to manage item. **alert very foundation setup only,now without writeToDisk, finding etc... 
---will SRDataProcessor --- function api for custome function run with data.
