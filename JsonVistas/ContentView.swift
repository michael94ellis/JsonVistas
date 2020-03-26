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
    @State var draggableItemBuilder: DraggableItem = DraggableItem(size: .zero, bounds: .zero)
    @State var newSizeX :String = "50"
    @State var newSizeY :String = "50"
    
    @State var nameTextField: String = ""
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    
    var body: some View {
        HStack {
            ZStack {
                if !itemsContainer.views.isEmpty {
                    ForEach(self.itemsContainer.views.indices, id: \.self) { index in
                        self.itemsContainer.views[index]
                            .position(x: self.itemsContainer.viewModels[index].size.width, y: self.itemsContainer.viewModels[index].size.height)
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
                        TextField(newSizeX, text: $newSizeX)
                            .frame(width: 50, height: 30, alignment: .center)
                        Text(", Y:")
                        TextField(newSizeY, text: $newSizeY)
                            .frame(width: 50, height: 30, alignment: .center)
                        Text(")")
                    }
                    Button("Add View", action: {
                        self.draggableItemBuilder.name = self.nameTextField
                        self.nameTextField = ""
                        self.draggableItemBuilder.size.width = CGFloat(Int(self.newSizeX) ?? 50)
                        self.draggableItemBuilder.size.height = CGFloat(Int(self.newSizeY) ?? 50)
                        self.newSizeX = "0"
                        self.newSizeY = "0"
                        self.draggableItemBuilder.parentBounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
                        self.itemsContainer.viewModels.append(self.draggableItemBuilder)
                        self.itemsContainer.views.append(DraggableRect(index: self.itemsContainer.views.count))
                        self.draggableItemBuilder = DraggableItem(size: .zero, bounds: .zero)
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
