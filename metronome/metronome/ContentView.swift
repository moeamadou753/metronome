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

    func validate(bpm: String) {}
    
    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("Input BPM")) {
                    TextField("", text:  Binding<String>(
                        get: { String($clock.bpm.wrappedValue)},
                        set: { newValue in if let intValue = Int(newValue) {
                            clock.updateTimeSignature(bpm: intValue)
                        }}))
                        .onSubmit {
                            validate(bpm: bpmInput)
                        }.disableAutocorrection(true)
                }
            }
            Button(action: $clock.running.wrappedValue ? clock.stop : clock.start) {
                Text("*")
                    .onChange(of: $clock.running.wrappedValue) { _ in
                    print("changed")
                }
            } .frame(width:100, height:100, alignment: .center)
        }
        .frame(width: 200, height: 300)
    }
}

#Preview {
    ContentView()
}
