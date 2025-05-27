//
//  ContentView.swift
//  metronome
//
//  Created by Moe Amadou on 5/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var clock: Clock = Clock()
    @State var bpmInput: String = ""
    @State var sliderValue: Double = 0
    
    init() {
        _bpmInput = State(initialValue: String(clock.bpm))
        _sliderValue = State(initialValue: Double(clock.bpm))
    }
    
    func validate(bpm: String) -> Bool {
        let intValue = Int(bpm)
        
        if (intValue == nil) {
            return false
        }
        
        if (intValue! > 0 && intValue! < 500) {
            clock.updateTimeSignature(bpm: intValue!)
            return true
        }
        
        return false
    }
    
    func validate(bpm: Double) {
        let intValue = Int(bpm)
        
        if (intValue > 0 && intValue < 500) {
            clock.updateTimeSignature(bpm: intValue)
        }
    }
    
    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("BPM")) {
                    TextField("", text: $bpmInput)
                        .onSubmit {
                            if (!validate(bpm: bpmInput)) {
                                bpmInput = String(clock.bpm)
                            }
                        }.disableAutocorrection(true)
                        .onChange(of: $clock.bpm.wrappedValue) {
                            bpmInput = String(clock.bpm)
                        }
                }
            }
            Slider(value: $sliderValue,
                   in: 1...300, step: 1,
                   onEditingChanged: { isEditing in if (!isEditing) { validate(bpm: sliderValue)}}
                   
            ).onChange(of: $clock.bpm.wrappedValue) {
                value in sliderValue = Double(value)
            }
            Button(action: $clock.running.wrappedValue ? clock.stop : clock.start) {
                Text(">")
            } .frame(width:100, height:100, alignment: .center)
            
            HStack(alignment: .center) {
                Button(action: {() in clock.incrementBpm(interval: 2)}) {
                    Text("+2")
                }
                Button(action: {() in clock.decrementBpm(interval: 2)}) {
                    Text("-2")
                }
            }
        }
        .frame(width: 200, height: 300)
    }
}

#Preview {
    ContentView()
}
