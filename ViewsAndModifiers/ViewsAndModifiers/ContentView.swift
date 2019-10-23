//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Todd Ayers on 10/23/19.
//  Copyright © 2019 Todd Ayers. All rights reserved.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack {
                    Text("Gryffindor")
                        .blur(radius: 0)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .blur(radius: 5)
                
                VStack(spacing: 10) {
                    CapsuleText(text: "First")
                        .foregroundColor(.green)
                    CapsuleText(text: "Second")
                }
                Text("Hello World")
                .modifier(Title())
                
                Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
                
                GridStack(rows: 4, columns: 4) { row, col in
                    Text("R\(row) C\(col)")
                }
                
                GridStack(rows: 4, columns: 4) { row, col in
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
