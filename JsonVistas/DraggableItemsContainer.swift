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
    
    public func remove(at index: Int) {
        self.views.remove(at: index)
        self.viewModels.remove(at: index)
    }
}
