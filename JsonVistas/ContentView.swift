//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var dropDelegate: DraggableViewDropDelegate
    @State public var draggableViews: [DraggableRect] = []
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    @State public var locs: [CGPoint] = []
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func newDragView() -> DraggableRect {
        locs.append(.zero)
        let index = locs.indices.count - 1
        return DraggableRect(location: $locs[index], parentBounds: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height)))
    }
    
    func addView() {
        self.draggableViews.append(newDragView())
    }
    
    var body: some View {
        HStack {
            ZStack {
                if !draggableViews.isEmpty {
                    ForEach(self.draggableViews.indices, id: \.self) { index in
                        self.draggableViews[index].position(x: 0, y: 0)
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .background(Rectangle().fill(Color.blue))
            .onDrop(of: [""], delegate: dropDelegate)
            VStack {
                Button("Add View", action: {
                    self.addView()
                })
                if !locs.isEmpty {
                    ForEach((0...self.locs.count - 1), id: \.self) { index in
                    Text("X: \(String(Int(self.locs[index].x))), Y: \(String(Int(self.locs[index].y)))")
                    }
                }
            }
            .frame(width: CGFloat(100), height: CGFloat(200), alignment: .leading)
            .padding(.trailing, CGFloat(20))
        }.padding(50)
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
