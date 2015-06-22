//
//  SRSavable.swift
//  StoreRoom
//
//  Created by goldunderknees on 21/6/15.
//  Copyright (c) 2015 goldunderknees. All rights reserved.
//

import Foundation

/// PlaceHolder Protocol to represent whether Items are savable
public protocol SRSavable{
    
}

extension String:SRSavable{
    
}

extension Int64:SRSavable{
    
}

extension NSDate:SRSavable{
    
}

extension NSData:SRSavable{
    
}

