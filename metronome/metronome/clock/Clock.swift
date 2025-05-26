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
    
    init (interval: TimeInterval) {
        self.interval = interval
    }
    
    func debounce(callback: @escaping () -> Void) -> Void {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [callback] _ in
            callback()
        }
        timer?.fire()
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
        self.debouncer = Debouncer(interval: TimeInterval(bpmToMs(bpm: 69) / 1000.0))
    }
    
    func start() -> Void {
        self.running = true
        debouncer.debounce(callback:Bus.requestBeat)
    }
    
    func stop() -> Void {
        self.running = false
        debouncer.stop()
    }
    
    func updateTimeSignature(bpm: Int) -> Void {
        self.bpm = bpm
        debouncer.interval = TimeInterval(bpmToMs(bpm: bpm) / 1000.0)
    }
}
