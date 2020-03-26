//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

class DraggableItemsContainer: ObservableObject {
    @Published public var views: [DraggableRect] = []
    @Published var viewModels: [DraggableItem] = []
}

struct ContentView: View {
    
    var dropDelegate: DraggableViewDropDelegate
    @State var size: CGSize = CGSize(width: 414, height: 736)
    @State var nameTextField: String = ""
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    
    init() {
        dropDelegate = DraggableViewDropDelegate()
    }
    
    func makeDraggableItemModel(name: String) {
        let newDragItem = DraggableItem()
        newDragItem.parentBounds = CGRect(x: 0, y: 0, width: Int(self.size.width), height: Int(self.size.height))
        newDragItem.name = name
        self.itemsContainer.viewModels.append(newDragItem)
    }
    
    func getHorizontalString() -> String {
        var hStr = "H:|-"
        for view in (itemsContainer.viewModels.sorted { $0.currentPosition.x < $1.currentPosition.x }) {
            hStr += "(\(view.name))-"
        }
        hStr += "|"
        return hStr
    }
    
    func getVerticalString() -> String {
        var vStr = "V:|-"
        for view in (itemsContainer.viewModels.sorted { $0.currentPosition.y < $1.currentPosition.y }) {
            vStr += "(\(view.name))-"
        }
        vStr += "|"
        return vStr
    }
    
    var body: some View {
        HStack {
            ZStack {
                if !itemsContainer.views.isEmpty {
                    ForEach(self.itemsContainer.views.indices, id: \.self) { index in
                        self.itemsContainer.views[index]
                            .position(x: 60, y: 60)
                            .onLongPressGesture {
                                self.itemsContainer.views.remove(at: index)
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
                        self.makeDraggableItemModel(name: self.nameTextField)
                        self.itemsContainer.views.append(DraggableRect(index: self.itemsContainer.views.count))
                        self.nameTextField = ""
                    })
                }
                if !itemsContainer.views.isEmpty {
                    ForEach((0...self.itemsContainer.views.count - 1), id: \.self) { index in
                        Text("\(String(self.itemsContainer.viewModels[index].name)): (X: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.x))), Y: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.y))))")
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
