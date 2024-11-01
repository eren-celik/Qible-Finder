//
//  AudioManager.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation
import AVFoundation

final class AudioManager {
    
    public static let shared = AudioManager()
    private init(){}
    
    var player: AVAudioPlayer?

    func playSound() {
        let systemSoundID: SystemSoundID = 1117
        AudioServicesPlaySystemSound(systemSoundID)
    }
}

