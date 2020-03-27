//
//  InstructionsView.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/27/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import SwiftUI

struct InstructionsView: View {
    
    @EnvironmentObject var itemsContainer: DraggableItemsContainer
    
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
        itemsContainer.viewModels
            .sorted(by: { $0.currentPosition.y > $1.currentPosition.y })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let thisViewsBreadth = view.currentPosition.y...(view.currentPosition.y + view.size.height)
                let horiztontallyAdjacentViews = itemsContainer.viewModels.filter {
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
        itemsContainer.viewModels
            .sorted(by: { $0.currentPosition.x > $1.currentPosition.x })
            .forEach { view in
                for row in rows where row.contains(where: { $0.name == view.name }) {
                    return
                }
                let thisViewsBreadth = view.currentPosition.x...(view.currentPosition.x + view.size.width)
                let verticallyAdjacentViews = itemsContainer.viewModels.filter {
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
    
    private var formatStrings: String {
        var declaration = "let formatStrings: [String] = [\n"
        for string in getFormatStrings(tolerance: 10) {
            declaration.append("    " + string + ",\n")
        }
        return declaration + "]"
    }
    
    public var views: String {
        var declaration = "let views: [String: Any] = [\n"
        for view in itemsContainer.viewModels {
            declaration.append("    \"\(view.name)\": \(view.name),")
        }
        return declaration + "\n]"
    }
    
    public var constraintsInstructions: String {
        """
        \(views)
        
        \(formatStrings)
        
        
        var allConstraints: [NSLayoutConstraint] = []
        for formatString in formatStrings {
            allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: formatString,
            metrics: nil,
            views: views)
        }

        NSLayoutConstraint.activate(allConstraints)
        """
    }
    
    var body: some View {
        VStack {
            Text( """
            
            
            // How to use this array of format Strings in swift code:

            """)
            Text(constraintsInstructions)
            Button("Copy to Clipboard", action: {
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                pasteboard.setString(self.constraintsInstructions, forType: NSPasteboard.PasteboardType.string)
            })
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
