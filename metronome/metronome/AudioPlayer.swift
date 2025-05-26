//
//  AudioPlayer.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
//

import Foundation
import AVFoundation

let DEFAULT_METRONOME_PATH: String = "audio/clicks/quartz-metronome"
let DEFAULT_METRONOME_TYPE: String = ".wav"

func resolveSound(relativePath: String, audioType: String) -> String? {
    return Bundle.main.path(forResource: relativePath, ofType: audioType)
}


class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?
    @Published var isPlaying: Bool
    
    init() {
        if let sound = resolveSound(relativePath: DEFAULT_METRONOME_PATH, audioType: DEFAULT_METRONOME_TYPE) {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            } catch {
                print("Error processing audio path / type.")
            }
        } else {
            print("Invalid audio path / type received.")
        }
        isPlaying = false
    }
    
    func toggle() {
        if (player !== nil) { return }
            
        if (isPlaying) {
            player?.stop()
        } else {
            player?.play()
        }
        
        isPlaying = !isPlaying
    }
}
