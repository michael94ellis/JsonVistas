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
    var view: DraggableRect
    
    init(name: String, location: CGPoint, view: DraggableRect) {
        self.name = name
        self.location = location
        self.view = view
    }
}

struct ContentView: View {
    
    var dropDelegate: DraggableViewDropDelegate
    @State public var views: [DraggableViewReference] = []
    @State private var size: CGSize = CGSize(width: 414, height: 736)
    
    @State var nameTextField: String = ""
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func addView(name: String) {
        let newView = DraggableRect(parentBounds: CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height)))
        views.append(DraggableViewReference(name: name, location: newView.location?.wrappedValue ?? .zero, view: newView))
        
        // FIXME: viewLocation is linked with draggableView and causes reference problems
    }
    
    func getHorizontalString() -> String {
        var hStr = "H:|-"
        for view in (views.sorted { $0.location.x < $1.location.x }) {
            hStr += "(\(view.name))-"
        }
        hStr += "|"
        return hStr
    }
    
    func getVerticalString() -> String {
        var vStr = "V:|-"
        for view in (views.sorted { $0.location.y < $1.location.y }) {
            vStr += "(\(view.name))-"
        }
        vStr += "|"
        return vStr
    }
    
    var body: some View {
        HStack {
            ZStack {
                if !views.isEmpty {
                    ForEach(self.views.indices, id: \.self) { index in
                        self.views[index].view
                            .position(x: 60, y: 60)
                            .onLongPressGesture {
                                self.views.remove(at: index)
                        }
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .background(Rectangle().fill(Color.blue))
            .onDrop(of: [""], delegate: dropDelegate)
            VStack {
                HStack {
                    TextField("Enter a unique id or name", text: $nameTextField)
                        .frame(width: 200, height: 30, alignment: .center)
                    Button("Add View", action: {
                        self.addView(name: self.nameTextField)
                        self.nameTextField = ""
                    })
                }
                if !views.isEmpty {
                    ForEach((0...self.views.count - 1), id: \.self) { index in
                        Text("\(String(self.views[index].name)): (X: \(String(Int(self.views[index].location.x))), Y: \(String(Int(self.views[index].location.y))))")
                    }
                    Text(getHorizontalString())
                    Text(getVerticalString())
                }
            }
            .frame(width: size.width, height: size.height, alignment: .top)
            .padding(.trailing, CGFloat(20))
        }.padding(50)
    }
}

class DraggableViewDropDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}
extension CGSize {
    public var point: CGPoint {
        CGPoint(x: self.width, y: self.height)
    }
}
extension CGPoint {
    public var size: CGSize {
        CGSize(width: self.x, height: self.y)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
