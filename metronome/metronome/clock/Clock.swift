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

class MutableInstance {
    func useEffect(on instance: inout MutableInstance, mutation:(inout  MutableInstance) -> Void) -> Void {
        mutation(&instance)
    }
}

class Debouncer: MutableInstance {
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
    
    func stop() -> Void {
        timer?.invalidate()
    }
}

class Observer {
    func notify() {}
}

class Bus {
    var observers: [Observer]
    
    init(initObservers: [Observer]) {
        self.observers = []
    }
    
    func bindObservers(commitObservers: [Observer]) {
        observers.append(contentsOf: commitObservers)
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.notify()
        }
    }
    
    static func requestBeat() -> Void {
        print("boom")
    }
}

class Clock: MutableInstance {
    var paceMs: Int
    var running: Bool
    var debouncer: Debouncer
    
    init() {
        self.paceMs = bpmToMs(bpm: 69)
        self.running = false
        self.debouncer = Debouncer(interval: TimeInterval(paceMs))
    }
    
    func start() -> Void {
        running = true
        debouncer.debounce(callback:Bus.requestBeat)
    }
    
    func stop() -> Void {
        running = false
        debouncer.stop()
    }
    
    func updateTimeSignature(bpm: Int) -> Void {
        paceMs = bpmToMs(bpm: bpm)
    }
}
