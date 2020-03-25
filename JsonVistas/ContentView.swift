//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct DraggableViewReference {
    var name: String
    var location: CGPoint
    
    init(name: String, location: CGPoint) {
        self.name = name
        self.location = location
    }
}

struct ContentView: View {
    
    var dropDelegate: DraggableViewDropDelegate
    @State public var draggableViews: [DraggableRect] = []
    @State public var viewLocations: [DraggableViewReference] = []
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    @State var nameTextField: String = ""
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView(name: String) {
        viewLocations.append(DraggableViewReference(name: name, location: .zero))
        let index = viewLocations.count - 1
        let newView = DraggableRect(location: $viewLocations[index].location, parentBounds: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height)))
        draggableViews.append(newView)
    }
    
    func getHorizontalString() -> String {
        var hStr = "H:|-"
        for view in (viewLocations.sorted { $0.location.x < $1.location.x }) {
            hStr += "(\(view.name))-"
        }
        hStr += "|"
        return hStr
    }
    
    func getVerticalString() -> String {
        var vStr = "V:|-"
        for view in (viewLocations.sorted { $0.location.y < $1.location.y }) {
            vStr += "(\(view.name))-"
        }
        vStr += "|"
        return vStr
    }
    
    var body: some View {
        HStack {
            ZStack {
                if !draggableViews.isEmpty {
                    ForEach(self.draggableViews.indices, id: \.self) { index in
                        self.draggableViews[index]
                            .position(x: CGFloat(0), y: 0)
                            .onLongPressGesture {
                                if self.viewLocations.indices.contains(index) {
                                    self.viewLocations.remove(at: index)
                                }
                                self.draggableViews.remove(at: index)
                        }
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .background(Rectangle().fill(Color.blue))
            .onDrop(of: [""], delegate: dropDelegate)
            VStack {
                TextField("Enter a unique id or name", text: $nameTextField)
                Button("Add View", action: {
                    self.addView(name: self.nameTextField)
                })
                if !viewLocations.isEmpty {
                    ForEach((0...self.viewLocations.count - 1), id: \.self) { index in
                        Text("\(String(self.viewLocations[index].name)): (X: \(String(Int(self.viewLocations[index].location.x))), Y: \(String(Int(self.viewLocations[index].location.y))))")
                    }
                    Text(getHorizontalString())
                    Text(getVerticalString())
                }
            }
            .frame(width: CGFloat(400), height: CGFloat(200), alignment: .leading)
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
