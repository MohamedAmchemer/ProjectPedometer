//
//  AudioPlay.swift
//  CoreMotionPost
//
//  Created by MOUSSAAB on 23/11/2019.
//  Copyright © 2019 kamwysoc. All rights reserved.
//


import UIKit
import AVFoundation


class AudioPlay : UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = Bundle.main.path(forResource: "audio", ofType: "mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            
        }catch{
            print(error)
        }
    }
    @IBAction func audioplayButtonPressed(_ sender: Any) {
        audioPlayer.play()
        
    }
    
    @IBAction func audiopauseButtonPressed(_ sender: Any) {
        audioPlayer.play()
        
    }
    
}
