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
    
    var soundRecorder : AVAudioRecorder!
    var fileName = "/audioFile.m4a"
    var soundSession:AVAudioSession
    override init() {
        
        soundSession=AVAudioSession.sharedInstance()
        do
        {
        try soundSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try soundSession.setActive(true)
        }catch
        {
            let e=NSError()
            print("error loading session \(e.localizedDescription)")
            
        }
        super.init()
    }




    func getCacheDirectory() -> String {
        print("inside getCacheDirectory()")
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as! [String]
        print("this is the from the path array"+paths[0])
        return paths[0]
        
    }
    
    func getFileURL() -> URL{
        print("inside getFileURL()")
        let path  = getCacheDirectory()+fileName
        
        let filePath = URL(fileURLWithPath: path)
        
        return filePath
    }
    
    
    func setupRecorder()
    {
        
        

            let recordSettings = [AVFormatIDKey : kAudioFormatAppleLossless,
                                  AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                                  AVEncoderBitRateKey : 320000,
                                  AVNumberOfChannelsKey : 2,
                                  AVSampleRateKey : 44100.0 ] as [String: Any]
        
        
            do
            {
                soundRecorder = try AVAudioRecorder(url: getFileURL(), settings: recordSettings )
                soundRecorder.delegate = self
                print("file \(getFileURL())")
                soundRecorder.prepareToRecord()
            }
                
            catch
            {
                let e=NSError()
                
                
                    
                    NSLog("Something Wrong")
                    print(e.localizedDescription)
                
                
                
                
        }
        
            
    }



}

