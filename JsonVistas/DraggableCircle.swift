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
    
    var currentLocation: Binding<CGPoint>
    private var parentBounds = CGRect()

    let textFieldImage = Image("textfield").resizable()
    
    init(boundedBy: CGRect, location: Binding<CGPoint>) {
        parentBounds = boundedBy
        currentLocation = location
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
                print("Changed Position: \(self.currentPosition)")
                self.currentLocation.wrappedValue = self.currentPosition
        }
        .onEnded { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
            if self.inbounds {
                self.newPosition = self.currentPosition
                self.lastValidPosition = self.currentPosition
                self.currentLocation.wrappedValue = self.currentPosition
            } else {
                self.currentPosition = self.lastValidPosition
            }
            print("New Positon: \(self.newPosition)")
        }
    }
    
    private var inbounds: Bool {
        if self.currentPosition.x > parentBounds.maxX - size.width {
            self.currentPosition.x = parentBounds.maxX - size.width
        } else if self.currentPosition.x < parentBounds.minX {
            self.currentPosition.x = parentBounds.minX
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
            .frame(width: size.width, height: size.height)
            .offset(x: self.currentPosition.x, y: self.currentPosition.y)
            .gesture(drag)
            .background(textFieldImage.frame(width: size.width, height: size.height, alignment: .leading).offset(self.currentPosition.size))
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
