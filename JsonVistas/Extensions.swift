//
//  Extensions.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/26/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import Foundation

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
