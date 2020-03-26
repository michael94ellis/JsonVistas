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
    var viewModel: DraggableItem {
        if itemsContainer.viewModels.indices.contains(index) {
            return itemsContainer.viewModels[index]
        } else {
            print("No Index \(index)")
            // FIXME this is a hack to allow deleting
            // Problem: Deleting a viewModel from itemsContainer will trigger a view update, calling this
            // Crash is bc the index doesnt exist(one was deleted so one of the indices is now invalid
        }
        return DraggableItem()
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
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .position(x: 0, y: 0)
            .offset(x: self.viewModel.dragPosition.x, y: self.viewModel.dragPosition.y)
            .frame(width: self.viewModel.size.width, height: self.viewModel.size.height)
            .gesture(drag)
    }
}
