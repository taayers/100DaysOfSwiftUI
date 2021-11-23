//
//  ContentView.swift
//  BetterRest
//
//  Created by Todd Ayers on 11/23/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%.2f")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
