//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let stringMaker = ALVFStringMaker()
    var dropDelegate: DraggableViewDropDelegate = DraggableViewDropDelegate()
    @State var size: CGSize = CGSize(width: 414, height: 736)
    @State var draggableItemBuilder: DraggableItem = DraggableItem()
    @State var newSizeX :String = "0"
    @State var newSizeY :String = "0"
    
    @State var nameTextField: String = ""
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    
    var body: some View {
        HStack {
            ZStack {
                if !itemsContainer.views.isEmpty {
                    ForEach(self.itemsContainer.views.indices, id: \.self) { index in
                        self.itemsContainer.views[index]
                            .position(x: 60, y: 60)
                            .onLongPressGesture {
                                self.itemsContainer.remove(at: index)
                        }
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .background(Rectangle().fill(Color.blue))
            .onDrop(of: [""], delegate: dropDelegate)
            VStack {
                VStack {
                    HStack {
                        Text("id:")
                        TextField("Enter a unique id or name", text: $nameTextField)
                            .frame(width: 200, height: 30, alignment: .center)
                    }
                    HStack {
                        Text("size: ( X:")
                        TextField("0", text: $newSizeX)
                            .frame(width: 50, height: 30, alignment: .center)
                        Text(", Y:")
                        TextField("0", text: $newSizeY)
                            .frame(width: 50, height: 30, alignment: .center)
                        Text(")")
                    }
                    HStack {
                        Text("top spacing:")
                        TextField("0", text: .constant("0"))
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    HStack {
                        Text("left spacing:")
                        TextField("0", text: .constant("0"))
                            .frame(width: 50, height: 30, alignment: .center)
                        Text("right spacing:")
                        TextField("0", text: .constant("0"))
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    HStack {
                        Text("bottom spacing:")
                        TextField("0", text: .constant("0"))
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    Button("Add View", action: {
                        self.draggableItemBuilder.name = self.nameTextField
                        self.draggableItemBuilder.size.width = CGFloat(Int(self.newSizeX) ?? 50)
                        self.draggableItemBuilder.size.height = CGFloat(Int(self.newSizeY) ?? 50)
                        self.itemsContainer.viewModels.append(self.draggableItemBuilder)
                        self.itemsContainer.views.append(DraggableRect(index: self.itemsContainer.views.count))
                        self.draggableItemBuilder = DraggableItem()
                    })
                }
                if !itemsContainer.views.isEmpty {
                    ForEach((0...self.itemsContainer.views.count - 1), id: \.self) { index in
                        Text("\(String(self.itemsContainer.viewModels[index].name)): (X: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.x))), Y: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.y))))")
                    }
                    Text(stringMaker.getHorizontalString(viewModels: self.itemsContainer.viewModels))
                    Text(stringMaker.getVerticalString(viewModels: self.itemsContainer.viewModels))
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DraggableItemsContainer())
    }
}
