//
//  RecordCollectionViewCell.swift
//  blabby
//
//  Created by RONNY's MAC on 11/06/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RecordCollectionViewCell: UICollectionViewCell
{

    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var roundedImage: UIImageView!
    
    

    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeItCircle()

    }
    
    func makeItCircle() {
        
        self.roundedImage.layer.masksToBounds = true
        self.roundedImage.layer.cornerRadius  = CGFloat(roundf(Float(self.roundedImage.frame.size.width/2)))
    }
    
    
    func thisIsFavourited(_:UIGestureRecognizer){
        print("swiped up")
    }
    
   
}
