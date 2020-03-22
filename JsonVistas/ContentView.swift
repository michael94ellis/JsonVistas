//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        HStack {
            HStack {
                ScreenArea()
            }
            VStack {
                Text("Output")
                Text("V:|-(example)-|")
                Text("H:|-(example)-|")
            }
            .frame(width: 100, height: 200, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
        }.padding(50)
    }
}

struct DraggableCircle: View {
    
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(Color.red)
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .gesture(DragGesture()
                .onChanged { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
            }
                .onEnded { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                    print(self.newPosition.width)
                    self.newPosition = self.currentPosition
                }
        )
    }
}

struct ScreenArea: View {
    
    var body: some View {
        VStack {
            DraggableCircle()
            DraggableCircle()
        }
        .frame(width: 414, height: 736)
        .background(Rectangle()
                        .fill(Color.blue))
    }
}

struct MyDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
