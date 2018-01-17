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

var initialState:Bool=true

class RecordViewController: UIViewController
{
   
    
    lazy var recordObj = Record()
    var users = [User]()
    

    
    
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
                
                user.UID = snapshot.key
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

    //VIEW DID LOAD
    override func viewDidLoad()
    {
        
        self.blabPressedCircularStroke()
        
        super.viewDidLoad()
        
        
        fetchBlab()
        recordObj.setupRecorder()
        let longPress=UILongPressGestureRecognizer(target: self, action:#selector(bRecorderPressed(press:)))
            longPress.minimumPressDuration=0
            longPress.numberOfTouchesRequired=1
        
        bRecordButton.addGestureRecognizer(longPress)
        
        
     
      

        
    }
    //status bar light
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //applied function on blab recorder
    func bRecorderPressed(press:UILongPressGestureRecognizer)
        {
            
            print("brecordbutton long pressed")
            
            switch press.state
            {
            case .possible:
                print("in possible")
                recordObj.setupRecorder()
            case .began:
               
                print(" in began");
                bRecordButton.layer.borderColor = UIColor.blue.cgColor
                bRecordButton.isHighlighted=true
                recordObj.soundRecorder.record()
            case .ended:
               
                print(" in ended");
                bRecordButton.layer.borderColor = UIColor(displayP3Red: 244.0/255.0, green: 178.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
                bRecordButton.isHighlighted=false
                recordObj.soundRecorder.pause()
            default:
                print("long press gesture couldnt complete")
            }
            
            
            
        }

    }
    

