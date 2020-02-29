//
//  SoundManager.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 2/29/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var soundPlayer: AVAudioPlayer?
    
    enum soundEffect {
        
        case flip
        case right
        case wrong
        case shuffle
    }
    
    func playSound(type: soundEffect) {
        
        var fileName: String?
        
        switch type {
            
        case .flip:
            fileName = "cardflip"
        case .right:
            fileName = "dingcorrect"
        case .wrong:
            fileName = "dingwrong"
        case .shuffle:
            fileName = "shuffle"
        }
        
    
        let path = Bundle.main.path(forResource: fileName, ofType: ".wav")
        
        guard path != nil else {
            
            print("could not retrieve audio file path")
            return
        }
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        }
        catch {
            
            print("couldn't assign AVAudioPlayer instance")
            return
        }
    }
}
