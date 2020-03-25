//
//  DraggableView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI
import AppKit

struct DraggableView: View {
    
    @State private var currentPosition: CGPoint = .zero
    @State private var newPosition: CGPoint = .zero
    @State private var size: CGSize = CGSize(width: 200, height: 60)
    @State private var lastValidPosition: CGPoint = .zero
    @State private var isValidLocation = true
    
    private var parentBounds = CGRect()
    
    init(boundedBy: CGRect) {
        parentBounds = boundedBy
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
                print("Changed Position: \(self.currentPosition)")
        }
        .onEnded { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
            if self.inbounds {
                self.newPosition = self.currentPosition
                self.lastValidPosition = self.currentPosition
            } else {
                self.currentPosition = self.lastValidPosition
            }
            print("New Positon: \(self.newPosition)")
        }
    }
    
    private var inbounds: Bool {
        if self.currentPosition.x > parentBounds.maxX - 150 {
            self.currentPosition.x = parentBounds.maxX - 150
        } else if self.currentPosition.x < parentBounds.minX + 50 {
            self.currentPosition.x = parentBounds.minX + 50
        }
        if self.currentPosition.y > parentBounds.maxY - size.height - 20 {
            self.currentPosition.y = parentBounds.maxY - size.height - 20
        } else if self.currentPosition.y < parentBounds.minY - 20 {
            self.currentPosition.y = parentBounds.minY - 20
        }
        return true
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: size.width, height: size.height)
            .offset(x: self.currentPosition.x, y: self.currentPosition.y)
            .gesture(drag)
            .background(Text("FFF")
                .offset(self.currentPosition.size))
    }
}
extension CGSize {
    public var point: CGPoint {
        CGPoint(x: self.width, y: self.height)
    }
}
extension CGPoint {
    public var size: CGSize {
        CGSize(width: self.x, height: self.y)
    }
}
