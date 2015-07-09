//
//  Friend.swift
//  OlaKAse
//
//  Created by Juan Felipe Alvarez Saldarriaga on 6/24/15.
//  Copyright © 2015 Juan Felipe Alvarez Saldarriaga. All rights reserved.
//

import UIKit
import Parse

class Friend: PFObject, PFSubclassing {

    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Friend"
    }
}
