//
//  DraggableRect.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/25/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI
import Combine


struct DraggableRect: View {
    
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    @State var index: Int
    @State var editMode = false
    
    var viewModel: DraggableItem {
        if itemsContainer.viewModels.indices.contains(index) {
            return itemsContainer.viewModels[index]
        } else {
            print("No Index \(index)")
            // FIXME this is a hack to allow deleting
            // Problem: Deleting a viewModel from itemsContainer will trigger a view update, calling this
            // Crash is bc the index doesnt exist(one was deleted so one of the indices is now invalid
        }
        return DraggableItem(size: .zero, bounds: .zero)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.viewModel.dragPosition = CGSize(width: value.translation.width + self.viewModel.currentPosition.x, height: value.translation.height + self.viewModel.currentPosition.y).point
                print("Changed Position: \(self.viewModel.dragPosition)")
                self.itemsContainer.objectWillChange.send()
        }
        .onEnded { value in
            self.viewModel.dragPosition = CGSize(width: value.translation.width + self.viewModel.currentPosition.x, height: value.translation.height + self.viewModel.currentPosition.y).point
            // Keep things in bounds
            if self.viewModel.dragPosition.x > self.viewModel.parentBounds.maxX  - self.viewModel.size.width {
                self.viewModel.dragPosition.x = self.viewModel.parentBounds.maxX - self.viewModel.size.width
            } else if self.viewModel.dragPosition.x < self.viewModel.parentBounds.minX {
                self.viewModel.dragPosition.x = self.viewModel.parentBounds.minX
            }
            if self.viewModel.dragPosition.y > self.viewModel.parentBounds.maxY - self.viewModel.size.height {
                self.viewModel.dragPosition.y = self.viewModel.parentBounds.maxY - self.viewModel.size.height
            } else if self.viewModel.dragPosition.y < self.viewModel.parentBounds.minY {
                self.viewModel.dragPosition.y = self.viewModel.parentBounds.minY
            }
            self.viewModel.currentPosition = self.viewModel.dragPosition
            print("New Positon: \(self.viewModel.currentPosition)")
            self.itemsContainer.objectWillChange.send()
        }
    }
    
    var tap: some Gesture {
        TapGesture()
            .onEnded {
                self.editMode.toggle()
        }
    }
    
    var longPress: some Gesture {
        LongPressGesture()
            .onEnded { _ in
                self.editMode.toggle()
        }
    }
    
    var body: some View {
        Group {
            if editMode {
                TextField(self.viewModel.name, text: $itemsContainer.viewModels[index].name)
                    .gesture(self.longPress)
                    .frame(width: self.viewModel.size.width, height: self.viewModel.size.height / 2, alignment: .bottom)
                    .offset(x: self.viewModel.dragPosition.x - self.viewModel.size.width / 2, y: self.viewModel.dragPosition.y - self.viewModel.size.height / 2)
                    .background(
                        Rectangle()
                            .border(Color.green, width: 1.0)
                            .position(x: 0, y: 0)
                            .foregroundColor(Color.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25))
                            .offset(x: self.viewModel.dragPosition.x, y: self.viewModel.dragPosition.y)
                            .frame(width: self.viewModel.size.width, height: self.viewModel.size.height)
                            .gesture(longPress))
            } else {
                Rectangle()
                    .border(Color.green, width: 1.0)
                    .position(x: 0, y: 0)
                    .foregroundColor(Color.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25))
                    .offset(x: self.viewModel.dragPosition.x, y: self.viewModel.dragPosition.y)
                    .frame(width: self.viewModel.size.width, height: self.viewModel.size.height)
                    .gesture(drag)
                    .gesture(tap)
                    .gesture(longPress)
                    .background(Text(self.viewModel.name)
                        .foregroundColor(Color.black)
                        .offset(x: self.viewModel.dragPosition.x - self.viewModel.size.width / 2, y: self.viewModel.dragPosition.y - self.viewModel.size.height / 2))
            }
        }
    }
}
