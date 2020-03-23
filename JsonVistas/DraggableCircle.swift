//
//  DraggableCircle.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/22/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI
import AppKit

struct DraggableCircle: View {
    
    @State private var currentPosition: CGPoint = .zero
    @State private var newPosition: CGPoint = .zero
    @State private var isValidLocation = true
    
    private var parentBounds = CGRect()
    
    init(boundedBy: CGRect) {
        parentBounds = boundedBy
        print()
    }
    
    var body: some View {
        Circle()
            .fill(self.isValidLocation ? Color.green : Color.red)
            .frame(width: 100, height: 100)
            .offset(x: self.currentPosition.x, y: self.currentPosition.y)
            .gesture(DragGesture()
                .onChanged { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
                    print("CCC: \(self.currentPosition)")
            }
            .onEnded { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.x, height: value.translation.height + self.newPosition.y).point
                self.newPosition = self.currentPosition
                print("New: \(self.newPosition)")
                }
        )
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

struct DraggableCircle_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
             DraggableCircle(boundedBy: CGRect(x: 0, y: 0, width: g.size.width, height: g.size.height))
        }
    }
}
