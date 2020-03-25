//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State public var views = 0
    var dropDelegate: DraggableViewDropDelegate
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView() {
        self.views += 1
        print("YEE HAW")
    }
    
    var body: some View {
        HStack {
            HStack {
                Group {
                    if views > 0 {
                        ForEach(1..<views, id: \.self) { _ in
                            DraggableView(boundedBy: CGRect(x: -1 * self.views + 50, y: 20, width: Int(self.size.width), height: Int(self.size.height))).position(x: CGFloat(100), y: CGFloat(30))
                        }
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
