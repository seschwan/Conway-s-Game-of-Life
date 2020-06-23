//
//  World.swift
//  Conway's Game of Life
//
//  Created by Seschwan on 6/19/20.
//  Copyright © 2020 Seschwan. All rights reserved.
//

import Foundation

public class World {
    public var cells = [Cell]()
    public let size: Int
    
    public init(size: Int) {
        self.size = size
        
        for x in 0..<size {
            for y in 0..<size{
                let randomState = arc4random_uniform(3)
                let cell = Cell(x: x, y: y, state: randomState == 0 ? .alive : .dead)
                cells.append(cell)
            }
        }
    }
    
    // Double Buffer
    public func updateCells() {
        var updatedCells = [Cell]()
        let liveCells = cells.filter { $0.state == .alive}
        
        for cell in cells {
            let livingNeighbors = liveCells.filter { $0.isNeighbor(to: cell)}
            
            switch livingNeighbors.count {
            case 2...3 where cell.state == .alive:
                updatedCells.append(cell)
            case 3 where cell.state == .dead:
                let liveCell = Cell(x: cell.x, y: cell.y, state: .alive)
                updatedCells.append(liveCell)
            default:
                let deadCell = Cell(x: cell.x, y: cell.y, state: .dead)
                updatedCells.append(deadCell)
            }
            
        }
        
        cells = updatedCells
    }
}
