//
//  DraggableRect.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/25/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct DraggableRect: View {
    @State public var currentPosition: CGPoint = CGPoint(x: 0, y: 0)
    @State private(set) public var newPosition: CGPoint = .zero
    @State private var size: CGSize = CGSize(width: 60, height: 60)
    
    @Binding public var location: CGPoint
    public var parentBounds: CGRect
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
                print("Changed Position: \(self.currentPosition)")
        }
        .onEnded { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
            // Keep things in bounds
            if self.currentPosition.x > self.parentBounds.maxX  - self.size.width {
                self.currentPosition.x = self.parentBounds.maxX - self.size.width
            } else if self.currentPosition.x < self.parentBounds.minX {
                self.currentPosition.x = self.parentBounds.minX
            }
            if self.currentPosition.y > self.parentBounds.maxY - self.size.height {
                self.currentPosition.y = self.parentBounds.maxY - self.size.height
            } else if self.currentPosition.y < self.parentBounds.minY {
                self.currentPosition.y = self.parentBounds.minY
            }
            self.newPosition = self.currentPosition
            self.location = self.newPosition
            print("New Positon: \(self.newPosition)")
        }
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .position(x: 0, y: 0)
            .offset(x: self.currentPosition.x, y: self.currentPosition.y)
            .frame(width: size.width, height: size.height)
            .gesture(drag)
    }
}
