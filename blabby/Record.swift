//
//  Record.swift
//  blabby
//
//  Created by Ashutosh Mane on 10/06/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import Foundation
import AVFoundation

class Record:AVAudioRecorder, AVAudioRecorderDelegate{
   
//    var objPlayer = Player()
    var soundRecorder : AVAudioRecorder!
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


   
    
    func Recorder()
    {
        print("in recorder")
        print("number of records \(numberOfRecording)")
        

        numberOfRecording += 1
        print("number of records \(numberOfRecording)")
            
            let fileName = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(numberOfRecording).m4a")
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
                   
                
            }
            catch
            {   
                let e=NSError()
                NSLog("Something with recorder")
                print(e.localizedDescription)
            }
            
        
    }
    
//   // call this func in view_did_load of Class RecordingViewController to fetch saved recording
//    func fetchBlabRecordingFromUserDefaults()
//    {
//        if let blabRecordingNumber:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
//            numberOfRecording = blabRecordingNumber
//            print(" RCVC fetching from user defaults, recording number", numberOfRecording)
//
//        }
//    }

    
    
    
    


}

