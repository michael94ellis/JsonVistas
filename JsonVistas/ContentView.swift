//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State public var views: [DraggableView] = []
    private var newDragView: DraggableView {
        DraggableView(boundedBy: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height)))
    }
    var dropDelegate: DraggableViewDropDelegate
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView() {
        self.views.append(newDragView)
        print("YEE HAW")
    }
    
    var body: some View {
        HStack {
            ZStack {
                if !views.isEmpty {
                    ForEach(self.views.indices, id: \.self) { index in
                        self.views[index]
                            .position(x: 0, y: 0)
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
