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

    var body: some View {
        ScrollView {
            Button(action: $clock.running.wrappedValue ? clock.stop : clock.start) {
                Label("Toggle clock", systemImage: clock.running ? "minus" : "plus")
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
