//
//  ContentView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var dropDelegate: DraggableViewDropDelegate = DraggableViewDropDelegate()
    
    @State var size: CGSize = CGSize(width: 414, height: 736)
    @State var newSizeX: String = "50"
    @State var newSizeY: String = "50"
    @State var edgeMatchingTolerance: String = "10"
    @State var nameTextField: String = ""
    /// This is the draggable item that is in the staging area, hitting the add view button should add the view it represents to the screen area
    @State var draggableItemBuilder: DraggableItem = DraggableItem(name: "", size: .zero, bounds: .zero)
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    
    var body: some View {
        HStack {
            ZStack {
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
                .background(Rectangle().fill(Color.blue).cornerRadius(30))
                .onDrop(of: [""], delegate: dropDelegate)
            }
            .frame(width: size.width + 35, height: size.height + 40)
            .background(Rectangle().fill(Color.black).cornerRadius(50))
            .onDrop(of: [""], delegate: dropDelegate)
            VStack {
                VStack {
                    HStack {
                        Text("id:")
                        TextField("Enter a unique id or name", text: $nameTextField)
                            .frame(width: 200, height: 30, alignment: .center)
                    }
                    HStack {
                        Text("Width")
                        TextField(newSizeX, text: $newSizeX)
                            .frame(width: 50, height: 30, alignment: .center)
                        Text("Height")
                        TextField(newSizeY, text: $newSizeY)
                            .frame(width: 50, height: 30, alignment: .center)
                    }
                    Button("Add View", action: {
                        self.draggableItemBuilder.name = self.nameTextField
                        self.draggableItemBuilder.size.width = CGFloat(Int(self.newSizeX) ?? 50)
                        self.draggableItemBuilder.size.height = CGFloat(Int(self.newSizeY) ?? 50)
                        self.draggableItemBuilder.parentBounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
                        let newRect = DraggableRect(index: self.itemsContainer.views.count)
                        self.itemsContainer.add(newView: newRect, newModel: self.draggableItemBuilder)
                        // Reset things
                        self.draggableItemBuilder = DraggableItem(name: "", size: .zero, bounds: .zero)
                        self.newSizeX = "50"
                        self.newSizeY = "50"
                        self.nameTextField = ""
                    })
                }
                if !itemsContainer.views.isEmpty {
                    ForEach((0...self.itemsContainer.views.count - 1), id: \.self) { index in
                        Text("\(String(self.itemsContainer.viewModels[index].name)): (X: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.x))), Y: \(String(Int(self.itemsContainer.viewModels[index].dragPosition.y))))")
                    }
                    InstructionsView()
                }
            }
            .frame(width: size.width, height: size.height, alignment: .top)
            .padding(.trailing, CGFloat(20))
        }.padding(50)
    }
}

//// This provides a dynamic amount of textfields based on a string array
//ForEach(self.itemsContainer.getFormatStrings(tolerance: Int(self.edgeMatchingTolerance) ?? 10), id: \.self) { string in
//    FormatStringRow(formatString: string)
//}
///// An element for displaying dynamic string arrays as textfields
//struct FormatStringRow: View {
//    @State var formatString: String
//
//    var body: some View {
//        TextField(formatString, text: $formatString)
//    }
//}

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
