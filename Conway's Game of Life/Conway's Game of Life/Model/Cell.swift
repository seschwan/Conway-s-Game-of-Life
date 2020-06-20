//
//  Cell.swift
//  Conway's Game of Life
//
//  Created by Seschwan on 6/19/20.
//  Copyright © 2020 Seschwan. All rights reserved.
//

import Foundation


public enum State {
    case alive, dead
}

public struct Cell {
    public let x: Int
    public let y: Int
    public var state: State
    
    public func isNeighbor(to cell: Cell) -> Bool {
        let xDelta = abs(self.x - cell.x)
        let yDelta = abs(self.y - cell.y)
        
        switch (xDelta, yDelta) {
        case (1, 1), (0, 1), (1, 0):
            return true
        default:
            return false
        }
    }
    
}
