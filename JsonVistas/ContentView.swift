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
    var screenArea: ScreenArea?
    
    init() {
        self.screenArea = ScreenArea(display: $draggingItemLocation)
    }
    
    var body: some View {
        HStack {
            HStack {
                self.screenArea
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
    
    @State public var draggableViews: [String] = []
    
    var displayPoint: Binding<CGPoint>
    var dropDelegate: DraggableViewDropDelegate
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    init(display: Binding<CGPoint>) {
        displayPoint = display
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView() {
        self.draggableViews.append("DV")
        print("YEE HAW")
    }
    
    func buildView() -> DraggableView {
       return DraggableView(boundedBy: CGRect(x: -50, y: 0, width: self.size.width, height: self.size.height), location: self.displayPoint)
    }
    
    var body: some View {
        VStack {
            Button("Add View", action: {
                self.addView()
            })
            ForEach(draggableViews, id: \.self) { view in
                self.buildView()
            }
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
