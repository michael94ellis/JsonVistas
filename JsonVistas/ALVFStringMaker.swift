//
//  ALVFStringMaker.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/26/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import Foundation

struct ALVFStringMaker {

    func getHorizontalStrings(tolerance: Int, viewModels: [DraggableItem]) -> [String] {
        var rows: [[DraggableItem]] = []
        viewModels
            .sorted(by: { $0.currentPosition.y > $1.currentPosition.y })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let viewsInSameRow = viewModels.filter { $0.currentPosition.y <= view.currentPosition.y + CGFloat(tolerance) && $0.currentPosition.y >= view.currentPosition.y - CGFloat(tolerance) }
                rows.append(viewsInSameRow)
        }
        var strings: [String] = []
        for row in rows.sorted(by: { $0.first?.currentPosition.y ?? 0 > $1.first?.currentPosition.y ?? 0 }) {
            // Orientation
            var hStr = "H:"
            for index in row.indices {
                if index == 0 {
                    // Container Padding
                    hStr += Int(row[index].currentPosition.x) < tolerance ? "|" : "|-"
                }
                hStr += "(\(row[index].name)==\(Int(row[index].size.width)))"
                if index == row.count - 1 {
                    // Container Padding
                    let distanceToBottom = row[index].parentBounds.maxX - row[index].currentPosition.x - row[index].size.width
                    hStr += Int(distanceToBottom) < tolerance ? "|" : "-|"
                }
            }
            strings.append(hStr)
        }
        return strings
    }
    // FIXME: - recognize if items are in the bounds of others
    ///
    ///  [A][][][][][]
    ///
    ///  [B]          [C][][]
    ///  []          [][][]
    ///
    /// Expected:
    ///     V: A B
    ///     V: A C
    ///     H: A
    ///     H: B C
    ///
    
    func getVerticalStrings(tolerance: Int, viewModels: [DraggableItem]) -> [String] {
        var rows: [[DraggableItem]] = []
        viewModels
            .sorted(by: { $0.currentPosition.x > $1.currentPosition.x })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let viewsInSameRow = viewModels.filter { $0.currentPosition.x <= view.currentPosition.x + CGFloat(tolerance) && $0.currentPosition.x >= view.currentPosition.x - CGFloat(tolerance) }
                rows.append(viewsInSameRow)
        }
        var strings: [String] = []
        for row in rows.sorted(by: { $0.first?.currentPosition.x ?? 0 > $1.first?.currentPosition.x ?? 0 }) {
            var vStr = "V:"
            for index in row.indices {
                if index == 0 {
                    // Container Padding
                    vStr += Int(row[index].currentPosition.y) < tolerance ? "|" : "|-"
                }
                vStr += "(\(row[index].name)==\(Int(row[index].size.height)))"
                if index == row.count - 1 {
                    // Container Padding
                    let distanceToBottom = row[index].parentBounds.maxY - row[index].currentPosition.y - row[index].size.height
                    vStr += Int(distanceToBottom) < tolerance ? "|" : "-|"
                }
            }
            strings.append(vStr)
        }
        return strings
    }
}
