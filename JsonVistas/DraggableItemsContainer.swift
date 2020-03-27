//
//  DraggableItemsContainer.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/26/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import Foundation

class DraggableItemsContainer: ObservableObject {
    @Published var views: [DraggableRect] = []
    @Published var viewModels: [DraggableItem] = []
    /// The item that is currently being edited, set this to an existing item to edit it
    @Published var draggableItemBuilder: DraggableItem = DraggableItem(size: .zero, bounds: .zero)
    @Published var rowTolerance = 10
    @Published var columnTolerance = 10
    
    public func remove(at index: Int) {
        self.views.remove(at: index)
        self.viewModels.remove(at: index)
    }
}
