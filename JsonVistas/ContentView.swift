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
            .frame(width: CGFloat(100), height: CGFloat(200), alignment: .leading)
            .padding(.trailing, CGFloat(20))
        }.padding(50)
    }
}

struct ScreenArea: View {
    
    var body: some View {
        return VStack {
            DraggableCircle(boundedBy: CGRect(x: 50, y: 50, width: 414, height: 736))
        }
        .frame(width: 414, height: 736)
        .background(Rectangle().fill(Color.blue))
        .onDrop(of: ["myStuff"], delegate: MyDropDelegate())
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
