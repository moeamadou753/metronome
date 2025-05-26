//
//  Clock.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
//

import Foundation

func bpmToMs(bpm: Int) -> Int {
    // 120 BPM = 500ms / quarter
    return 25/6 * bpm;
}

class Debouncer {
    var interval: TimeInterval
    var timer: Timer?
    
    init (interval: TimeInterval) {
        self.interval = interval
    }
    
    func debounce(callback: @escaping () -> Void) -> Void {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [callback] _ in
            callback()
        }
    }
}

class Observer {
    func notify() {}
}


class Bus {
    var observers: [Observer]
    
    init() {
        self.observers = []
    }
    
    func bindObservers() {
        
    }
    
    func notifyObservers() {
        
    }
    
    func requestBeat() {
        
    }
}

struct Clock {
    var paceMs: Int
    var running: Bool
    
    init() {
        self.paceMs = bpmToMs(bpm: 69)
        self.running = false
    }
    
    mutating func start() -> Void {
        running = true
    }
    
    mutating func stop() -> Void {
        running = false
    }
    
    mutating func updateTimeSignature(bpm: Int) -> Void {
        paceMs = bpmToMs(bpm: bpm)
    }
}
