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

var initialState:Bool=false

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
    

    
    
    @IBOutlet weak var bControlView: UIView!
    
    @IBOutlet var bRecordButton: UIButton!
    @IBOutlet weak var bCancelButton: UIButton!
    @IBOutlet weak var bSendButton: UIButton!
    @IBOutlet weak var bTimerLabel: UILabel!
    
    
    
    //////fuction to make blabPressed Circular/////
    func blabPressedCircularStroke()
    {
        self.bRecordButton.backgroundColor = .clear
        self.bRecordButton.layer.cornerRadius = 37
        self.bRecordButton.layer.borderWidth = 4
        
        self.bRecordButton.layer.borderColor = UIColor(displayP3Red: 244.0/255.0, green: 178.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        
    }
    //VIEW DID LOAD
    fileprivate func fetchBlab() {
        let blabAccountByUID=Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(blabAccountByUID!).observe(.childAdded, with: { (snapshot) in
            
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
    
    override func viewDidLoad()
    {
        self.bControlView.isHidden = initialState
        self.blabPressedCircularStroke()
        super.viewDidLoad()
        fetchBlab()
        
        
     
      

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    
    
}
