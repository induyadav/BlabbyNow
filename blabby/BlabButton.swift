//
//  blabPressed.swift
//  blabby
//
//  Created by Indu Yadav on 14/01/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import UIKit

class BlabButton: UIButton {
    override init(_: UIButton) {
        print("init fo blabbutton ")
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor(red:244, green:178, blue:70, alpha:1).setFill()
        path.fill()
    }
    
}
