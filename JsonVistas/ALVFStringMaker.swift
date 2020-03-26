//
//  ALVFStringMaker.swift
//  JsonVistas
//
//  Created by Michael Ellis on 3/26/20.
//  Copyright © 2020 Mellis. All rights reserved.
//

import Foundation

struct ALVFStringMaker {
    
    func makeStrings(viewModels: [DraggableItem]) -> [String] {
        guard !viewModels.isEmpty else {
            return []
        }
        let strings: [String] = []
        
        
        return strings
    }
    
    func getHorizontalString(viewModels: [DraggableItem]) -> String {
        var hStr = "H:|-"
        for view in (viewModels.sorted { $0.currentPosition.x < $1.currentPosition.x }) {
            hStr += "(\(view.name))-"
        }
        hStr += "|"
        return hStr
    }
    
    func getVerticalString(viewModels: [DraggableItem]) -> String {
        var vStr = "V:|-"
        for view in (viewModels.sorted { $0.currentPosition.y < $1.currentPosition.y }) {
            vStr += "(\(view.name))-"
        }
        vStr += "|"
        return vStr
    }
}
