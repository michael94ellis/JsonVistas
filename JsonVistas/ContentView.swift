//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State public var images: [String] = []
    var dropDelegate: DraggableViewDropDelegate
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView() {
        self.images.append("textfield")
        print("YEE HAW")
    }
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    ForEach(images, id: \.self) { viewImage in
                        DraggableView(boundedBy: CGRect(x: -50, y: 20, width: self.size.width, height: self.size.height)).position(x: 100, y: 30)
                    }
                }
                .frame(width: size.width, height: size.height)
                .background(Rectangle().fill(Color.blue))
                .onDrop(of: ["drag.circle"], delegate: dropDelegate)
            }
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
