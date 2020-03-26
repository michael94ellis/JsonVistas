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
    @Published public var size: CGSize = CGSize(width: 60, height: 60)
    @Published public var parentBounds: CGRect = CGRect(x: 0, y: 0, width: 414, height: 736)
    @Published public var dragPosition: CGPoint = .zero
    @Published public var currentPosition: CGPoint = .zero
}
