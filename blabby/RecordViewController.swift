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
var blabRecordTime:Double?

class RecordViewController: UIViewController
{
   
    
    lazy var recordObj = Record()
    var users = [User]()
    

    
    
    @IBOutlet weak var bControlView: UIView!
    
    @IBOutlet weak var blabRecordTimeLabel: UILabel!
    @IBOutlet var bRecordButton: UIButton!
    @IBOutlet weak var bCancelButton: UIButton!
    @IBOutlet weak var bSendButton: UIButton!
    @IBOutlet weak var bTimerLabel: UILabel!
    
   
   
    @IBAction func bSendButtonPressed(_ sender: Any) {
        
        
       
         try recordObj.soundRecorder.stop()
        print(" stopped successfully")
        initialState=true
        bControlViewToggle(state: initialState)
        
    }
    
    weak var shapeLayer: CAShapeLayer?
    //////fuction to make blabPressed Circular/////
    func blabPressedCircularStroke()
    {
        self.bRecordButton.backgroundColor = .clear
        self.bRecordButton.layer.cornerRadius = 37
        self.bRecordButton.layer.borderWidth = 4

        self.bRecordButton.layer.borderColor = UIColor(displayP3Red: 244.0/255.0, green: 178.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        print("this fucntion calll or ashu changed")
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

    
    func applicationWillEnterForeground(_ application: UIApplication) {
      fetchBlab()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(" in viewWillAppear")
        bControlViewToggle(state:initialState)
        
    }
    override func viewDidLoad()
    {
       
        self.blabPressedCircularStroke()
//        recordObj.soundRecorder.prepareToRecord()
        
        super.viewDidLoad()
        
        
        
        recordObj.setupRecorder()
        let longPress=UILongPressGestureRecognizer(target: self, action:#selector(bRecorderPressed(press:)))
            longPress.minimumPressDuration=0
            longPress.numberOfTouchesRequired=1
            longPress.allowableMovement=100
        
        
        bRecordButton.addGestureRecognizer(longPress)
        
        
     
      

        
    }
    //status bar light
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //applied function on blab recorder
    func bRecorderPressed(press:UILongPressGestureRecognizer)
        {
            if press.state == .began
            {
                print(" in began");
                bRecordButton.layer.borderColor = UIColor.blue.cgColor
                bRecordButton.isHighlighted=true
                recordObj.soundRecorder.record()
                initialState=false
                bControlViewToggle(state: initialState)
               
            }
            else if press.state == .ended
            {
                print(" in ended");
                bRecordButton.layer.borderColor = UIColor(displayP3Red: 244.0/255.0, green: 178.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
                bRecordButton.isHighlighted=false
                recordObj.soundRecorder.pause()
                blabRecordTime=recordObj.soundRecorder.currentTime
                print("recording time is \(String(describing: blabRecordTime))")
               
            }

        }
    func bControlViewToggle(state:Bool) -> Void
    {
        bControlView.isHidden=state
        bControlView.setNeedsDisplay()
        
    }

    }
    

