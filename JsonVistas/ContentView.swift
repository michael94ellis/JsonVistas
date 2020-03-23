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
    var dropDelegate: DraggableCircleDropDelegate
    
    init(display: Binding<CGPoint>) {
        displayPoint = display
        dropDelegate = DraggableCircleDropDelegate()
    }
    
    var body: some View {
        VStack {
            DraggableCircle(boundedBy: CGRect(x: 50, y: 50, width: 414, height: 736), location: displayPoint)
            .position(x: 0, y: 0)
        }
        .frame(width: 414, height: 736)
        .background(Rectangle().fill(Color.blue))
        .onDrop(of: ["drag.circle"], delegate: dropDelegate)
    }
}

class DraggableCircleDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
