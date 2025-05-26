//
//  AudioPlayer.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
//

import Foundation
import AVFoundation


var DEFAULT_METRONOME_PATH = "quartz-metronome"
var DEFAULT_METRONOME_TYPE: String = ".wav"

func resolveSound(relativePath: String, audioType: String) -> String? {
    return Bundle.main.path(forResource: "quartz-metronome", ofType: audioType, inDirectory: "audio")
}

var AUDIO_PLAYER: AVAudioPlayer?

class AudioPlayer {
    static func beat() {
        if let sound = resolveSound(relativePath: DEFAULT_METRONOME_PATH, audioType: DEFAULT_METRONOME_TYPE) {
            do {
                AUDIO_PLAYER = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                AUDIO_PLAYER?.play()
            } catch {
                print("Error processing audio path / type.")
            }
        } else {
            print("Invalid audio path / type received.")
        }
    }
}
