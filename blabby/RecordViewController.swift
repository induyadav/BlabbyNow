//
//  ViewController.swift
//  blabby
//
//  Created by Ashutosh Mane on 08/06/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase



class RecordViewController: UIViewController
{
    //the colour of the status bar
    var audioRecorder:AVAudioRecorder?
    var users = [User]()
    var blabRecorder:AVAudioRecorder?
//    public var file:NSURL{
//        get{
//            return getFileURL()
//        }
//    }
//    
    //Identifier for cell
    

    
    
    
    @IBOutlet var blabPressed: UIButton!
    @IBOutlet weak var cancelRecording: UIButton!
    @IBOutlet weak var sendRecording: UIButton!
    @IBOutlet weak var timerDigit: UILabel!
    
    
    //////fuction to make blabrPressed Circular/////
    func blabPressedCircularStroke()
    {
        self.blabPressed.backgroundColor = .clear
        self.blabPressed.layer.cornerRadius = 37
        self.blabPressed.layer.borderWidth = 2
        
        self.blabPressed.layer.borderColor = UIColor(red: 244, green: 178, blue: 70, alpha: 1).cgColor
    }
    
    override func viewDidLoad()
    {
        self.blabPressedCircularStroke()
        super.viewDidLoad()
        
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            print("uid is  \(uid!)")

            print(snapshot)
            if (snapshot.value as? [String: AnyObject]) != nil{
            print(" this is the user id snapshot \(snapshot.self)")

        }
    }, withCancel : nil)
     
      
        
            Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            
            if let snapshotSaved = snapshot.value as? [String: AnyObject] {
            
            //model being initialised
                let user = User(dictionary: snapshotSaved)
                user.name = snapshotSaved["name"] as? String
                user.number = snapshotSaved["number"] as? String
                print("fetch user accessed")
                print(snapshotSaved)
                
                user.id = snapshot.key
                self.users.append(user)
                print(user.name!, user.number!)
                
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                
//                DispatchQueue.main.async(execute: {
//                RecordCollectionViewController.RecordCollectionView.reloadData()
//
                
//                })
//                
                
            }
            
        }, withCancel: nil)
        
    }
    
    
    
    
  
    
    
    
    
    
    

}
