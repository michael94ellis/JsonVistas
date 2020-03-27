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
    
    public func add(newView: DraggableRect, newModel: DraggableItem) {
        self.views.append(newView)
        self.viewModels.append(newModel)
    }
    
    public func remove(at index: Int) {
        self.views.remove(at: index)
        self.viewModels.remove(at: index)
    }
    
    // MARK: - Format Strings

    enum FormatOrientation {
        case vertical
        case horizontal
    }
    
    public func getFormatStrings(tolerance: Int) -> [String] {
        var formatStrings = makeStrings(orientation: .horizontal, tolerance: tolerance, rows: horizontallyAdjecentViewRows)
        formatStrings.append(contentsOf: makeStrings(orientation: .vertical, tolerance: tolerance, rows: verticallyAdjecentViewRows))
        return formatStrings
    }
    
    private var horizontallyAdjecentViewRows: [[DraggableItem]] {
        var rows: [[DraggableItem]] = []
        viewModels
            .sorted(by: { $0.currentPosition.y > $1.currentPosition.y })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let thisViewsBreadth = view.currentPosition.y...(view.currentPosition.y + view.size.height)
                let horiztontallyAdjacentViews = viewModels.filter {
                    let currentViewBreadth = $0.currentPosition.y...($0.currentPosition.y + $0.size.height)
                    return currentViewBreadth.overlaps(thisViewsBreadth)
                }
                rows.append(horiztontallyAdjacentViews
                    .sorted(by: { $0.currentPosition.x < $1.currentPosition.x }))
        }
        return rows
    }
    
    private var verticallyAdjecentViewRows: [[DraggableItem]] {
        var rows: [[DraggableItem]] = []
        viewModels
            .sorted(by: { $0.currentPosition.x > $1.currentPosition.x })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let thisViewsBreadth = view.currentPosition.x...(view.currentPosition.x + view.size.width)
                let verticallyAdjacentViews = viewModels.filter {
                    let currentViewBreadth = $0.currentPosition.x...($0.currentPosition.x + $0.size.width)
                    return currentViewBreadth.overlaps(thisViewsBreadth)
                }
                rows.append(verticallyAdjacentViews
                    .sorted(by: { $0.currentPosition.y < $1.currentPosition.y }))
        }
        return rows
    }
    
    private func makeStrings(orientation: FormatOrientation, tolerance: Int, rows: [[DraggableItem]]) -> [String] {
        var strings: [String] = []
        for row in rows.sorted(by: { $0.first?.currentPosition.x ?? 0 > $1.first?.currentPosition.x ?? 0 }) {
            var str = orientation == .vertical ? "V:" : "H:"
            for index in row.indices {
                if index == 0 {
                    // Container Padding
                    str += Int(row[index].currentPosition.y) < tolerance ? "|" : "|-"
                } else {
                    str += "-"
                }
                str += "[\(row[index].name)]" // TODO add widths and heights, (==\(Int(row[index].size.height))
                if index == row.count - 1 {
                    // Container Padding
                    let distanceToBottom = row[index].parentBounds.maxY - row[index].currentPosition.y - row[index].size.height
                    str += Int(distanceToBottom) < tolerance ? "|" : "-|"
                }
            }
            strings.append(str)
        }
        return strings
    }
}
