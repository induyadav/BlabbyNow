//
//  Player.swift
//  blabby
//
//  Created by Indu Yadav on 27/03/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Player : AVAudioPlayer, AVAudioRecorderDelegate{
    
   
     var soundPlayer : AVAudioPlayer!
//     var blabRecordings = [URL]()
    var blabRecordings:[URL]=[]
    
    
    
    func blabPlayer(path:URL)
    {
        do{ soundPlayer = try AVAudioPlayer(contentsOf: path)
            soundPlayer.play()
           }
        catch
            { print("Some problem in blabPlayer in Class Record.swift")
            }
    }

    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        print("get directory created")
        return documentDirectory
        
    }
    
    func listOfRecordings()
    {
        do{
            let urls = try FileManager.default.contentsOfDirectory(at: getDirectory(), includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            self.blabRecordings = urls.filter( { (name: URL) -> Bool in
            return name.lastPathComponent.hasSuffix("m4a")
            })
       
        }
        catch
        {
            print(error.localizedDescription)
        }
    }



}
