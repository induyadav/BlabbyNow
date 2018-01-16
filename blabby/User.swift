//
//  User.swift
//  blabby
//
//  Created by Indu Yadav on 28/10/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import UIKit

class User: NSObject {
    var UID: String?
    var name: String?
    var number: String?
    var bDownloadURL: String?
   
    init(dictionary: [String: AnyObject]) {
        self.UID = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.number = dictionary["number"] as? String ?? ""
        self.bDownloadURL = dictionary["URL"] as? String
    }
}



  
