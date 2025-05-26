//
//  Clock.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
//

import Foundation

func bpmToMs(bpm: Int) -> Double {
    return 60000.0 / Double(bpm);
}

class MutableInstance {
    func useEffect(on instance: inout MutableInstance, mutation:(inout  MutableInstance) -> Void) -> Void {
        mutation(&instance)
    }
}

class Debouncer: MutableInstance {
    var interval: TimeInterval
    var timer: Timer?
    var callback: () -> Void
    
    init (interval: TimeInterval, cb: @escaping () -> Void) {
        self.interval = interval
        self.callback = cb
    }
    
    func start() -> Void {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [callback] _ in
            callback()
        }
        timer?.fire()
    }
    
    func stop() -> Void {
        timer?.invalidate()
    }
    
    func restart() -> Void {
        stop()
        start()
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
        AudioPlayer.beat()
    }
}

class Clock: MutableInstance, ObservableObject {
    @Published var running: Bool
    @Published var bpm: Int
    private var debouncer: Debouncer
    
    override init() {
        self.bpm = 69
        self.running = false
        self.debouncer = Debouncer(interval: TimeInterval(bpmToMs(bpm: 69) / 1000.0), cb:Bus.requestBeat)
    }
    
    func start() -> Void {
        if (self.running) {
            restart()
        } else {
            self.running = true
            debouncer.start()
        }
        
    }
    
    func stop() -> Void {
        self.running = false
        debouncer.stop()
    }
    
    func restart() {
        stop()
        start()
    }
    
    func updateTimeSignature(bpm: Int) -> Void {
        self.bpm = bpm
        debouncer.interval = TimeInterval(bpmToMs(bpm: bpm) / 1000.0)
        
        if (self.running) {
            restart()
        } else {
            start()
        }
    }
    
    func incrementBpm(interval: Int) -> Void {
        if (bpm <= (300 - interval)) {
            updateTimeSignature(bpm: bpm + interval)
        }
    }
    
    func decrementBpm(interval: Int) -> Void {
        if (bpm >= (1 + interval)) {
            updateTimeSignature(bpm: bpm - interval)
        }
    }
}
