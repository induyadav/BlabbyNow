//
//  Record.swift
//  blabby
//
//  Created by Ashutosh Mane on 10/06/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Record:AVAudioRecorder, AVAudioRecorderDelegate{
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var soundSession:AVAudioSession
    var numberOfRecording = 0
    
    
    override init()
    {
        soundSession=AVAudioSession.sharedInstance()
            do
            {   try soundSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try soundSession.setActive(true)
                print("Audio Session created")
            }
            catch
            {   let e=NSError()
                print("error loading session \(e.localizedDescription)")
            }
        super.init()
    }


    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        print("get directory created")
        return documentDirectory
        
    }
    
    func Recorder()
    {   print("number of records \(numberOfRecording)")
        if soundRecorder == nil
        {   print("sondRecorder == nil")
            
            numberOfRecording += 1
            print("number of records \(numberOfRecording)")
            
            let fileName = getDirectory().appendingPathComponent("\(numberOfRecording).m4a")
            print("file name just created = \(fileName)")
            let recordSettings = [AVFormatIDKey : kAudioFormatAppleLossless,
                                  AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                                  AVEncoderBitRateKey : 320000,
                                  AVNumberOfChannelsKey : 2,
                                  AVSampleRateKey : 44100.0 ] as [String: Any]
            print("Recording settings ready now")
            do
            {       soundRecorder = try AVAudioRecorder(url: fileName, settings: recordSettings )
                    soundRecorder.delegate = self
                    print("file \(fileName)")
                    print("file \(getDirectory())")
                  
            }
            catch
            {   
                let e=NSError()
                NSLog("Something Wrong")
                print(e.localizedDescription)
            }
            
        }
        else{
            print("in else of the record.swift")
            UserDefaults.standard.set(numberOfRecording, forKey: "myNumber")
            
        }
    }
    
   // call this func in view_did_load of Class RecordingViewController to fetch saved recording
    func fetchBlabRecordingFromUserDefaults()
    {
        if let blabRecordingNumber:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecording = blabRecordingNumber
            print(" RCVC fetching from user defaults, recording number", numberOfRecording)
           
        }
    }

    
    func blabPlayer(path:URL)
    {
        do{
            soundPlayer = try AVAudioPlayer(contentsOf: path)
            soundPlayer.play()
           
        }
        catch{
            
            print("Some problem in blabPlayer in Class Record.swift")
            
        }
    }
    
    


}

