//
//  Record.swift
//  blabby
//
//  Created by Ashutosh Mane on 10/06/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//

import Foundation
import AVFoundation

class Record{
    init() {
        print("init")
    }
    
    var soundFileURL:URL?=nil
    //var declaration
    var audioRecorder:AVAudioRecorder?
    
    //file directory making
    func directoryMaking()->URL
    {
    let fileMgr = FileManager.default
    
    let dirPaths = fileMgr.urls(for: .documentDirectory,
                                in: .userDomainMask)
    let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        return soundFileURL
    }
    
       
    
    // Audio settings
   var recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
         AVEncoderBitRateKey: 16,
         AVNumberOfChannelsKey: 2,
         AVSampleRateKey: 44100.0] as [String : Any]

//    do {
//          try  audioRecorder = AV
//    }
//    
//
    /*func startRecording(press:UILongPressGestureRecognizer){
        
        
        if press.state == .began{
            recorder.record(forDuration: 8)
            
            
        }
        else if press.state == .ended{
            recorder.pause()
            
        }
        
    }
*/
    
}
