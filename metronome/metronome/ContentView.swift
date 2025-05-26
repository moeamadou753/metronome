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

    init() {
        _bpmInput = State(initialValue: String($clock.bpm.wrappedValue))
    }
    
    func validate(bpm: String) {
        let intValue = Int(bpm)
        
        if (intValue == nil) {
            return
        }
        
        if (intValue! > 0 && intValue! < 500) {
            clock.updateTimeSignature(bpm: intValue!)
        }
    }
    
    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("BPM")) {
                    TextField("", text: $bpmInput)
                        .onSubmit {
                            validate(bpm: bpmInput)
                        }.disableAutocorrection(true)
                        .onChange(of: $clock.bpm.wrappedValue) {
                            bpmInput = String(clock.bpm)
                        }
                }
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
