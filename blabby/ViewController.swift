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



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource

{   //the colour of the status bar
    var audioRecorder:AVAudioRecorder?
    let reuseIdentifier = "Collection_Cell"
    
    var users = [User]()
    
    //Identifier for cell
    

    
    
    @IBOutlet weak var RecordCollectionView: UICollectionView!
    @IBOutlet var blabPressed: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cancelRecording: UIButton!
    @IBOutlet weak var sendRecording: UIButton!
    @IBOutlet weak var timerDigit: UILabel!
    
    
    
    
    override func viewDidLoad()
    {
        
        RecordCollectionView.dataSource = self
        RecordCollectionView.delegate=self
        super.viewDidLoad()
        
        // guestures
        let oneTap = UITapGestureRecognizer(target: self, action : #selector(ViewController.playRecording(_:)))
        oneTap.numberOfTapsRequired = 1
        self.RecordCollectionView?.addGestureRecognizer(oneTap)
        let longPressTap = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.startRecording(_:)))
        self.RecordCollectionView?.addGestureRecognizer(longPressTap)
        recordButton.addGestureRecognizer(longPressTap)
        let swipeUpTap = UISwipeGestureRecognizer(target: self, action:#selector(ViewController.thisIsFavourited(_:)))
        swipeUpTap.direction = UISwipeGestureRecognizerDirection.up
        self.RecordCollectionView?.addGestureRecognizer(swipeUpTap)
        let cancelOneTap  = UITapGestureRecognizer(target: self, action : #selector(ViewController.CancelRecordingToCoreData(_:)))
        cancelRecording.addGestureRecognizer(cancelOneTap)
        let sendOneTap = UITapGestureRecognizer(target: self, action : #selector(ViewController.SendRecordingToCoreData(_:)))
        sendRecording.addGestureRecognizer(sendOneTap)

       fetchUser()
        
    }
    
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                user.id = snapshot.key
                self.users.append(user)
                print(user.name!, user.number!)
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.RecordCollectionView.reloadData()
                })
                
                //                user.name = dictionary["name"]
            }
            
        }, withCancel: nil)
    }

    
    // collectionviewcell components
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{return users.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as UICollectionViewCell
        if let textCell = cell as? RecordCollectionViewCell{
            let user = users[indexPath.row]
            
                textCell.myLabel.text = user.name 
            textCell.roundedImage.image = #imageLiteral(resourceName: "image1") }
        return cell
    }

    
    
    
    
    func playRecording(_:UITapGestureRecognizer!)
        {
            print("it is playing recoreding")
        }
    func startRecording(_: UILongPressGestureRecognizer!)
        {
            print(" started recording")
        }
    func stopRecording(_: UITapGestureRecognizer!)
        {
            print(" stopped recording")
        }
    func SendRecordingToCoreData(_: UITapGestureRecognizer!)->()
        {
        if sendRecording.isEnabled{
            print("sent recording")}
        }
    func CancelRecordingToCoreData(_: UITapGestureRecognizer!)->()
        {   if cancelRecording.isEnabled{
            print("cancelled recording")}
        }
    func thisIsFavourited(_: UISwipeGestureRecognizer!)
        {
            print("favourited")
        }
    func fetchREcordingFromCoreData()
        {
            print("fetching recording")
        }
    func showToCollectionViewCell()->()
        {
            print("showing recording in collection view")
        }



}
