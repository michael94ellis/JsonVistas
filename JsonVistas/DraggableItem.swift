//
//  DraggableItem.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/26/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import Foundation

class DraggableItem: ObservableObject {
    @Published public var name: String = "example_name"
    @Published public var size: CGSize
    @Published public var parentBounds: CGRect
    @Published public var dragPosition: CGPoint = .zero
    @Published public var currentPosition: CGPoint = .zero
    
    init(size: CGSize, bounds: CGRect) {
        self.size = size
        self.parentBounds = bounds
    }
}
