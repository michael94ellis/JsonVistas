//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var draggingItemLocation: CGPoint = .zero
    
    var body: some View {
        HStack {
            HStack {
                ScreenArea(display: $draggingItemLocation)
            }
            VStack {
                Text("Current Position")
                Text("X: \(draggingItemLocation.x)")
                Text("Y: \(draggingItemLocation.y)")
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
    
    var displayPoint: Binding<CGPoint>
    var dropDelegate: DraggableViewDropDelegate
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    init(display: Binding<CGPoint>) {
        displayPoint = display
        dropDelegate = DraggableViewDropDelegate()
    }
    
    var body: some View {
        VStack {
            DraggableView(boundedBy: CGRect(x: 0, y: 0, width: size.width, height: size.height), location: displayPoint)
            .position(x: 100, y: 50)
        }
        .frame(width: size.width, height: size.height)
        .background(Rectangle().fill(Color.blue))
        .onDrop(of: ["drag.circle"], delegate: dropDelegate)
    }
}

class DraggableViewDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
