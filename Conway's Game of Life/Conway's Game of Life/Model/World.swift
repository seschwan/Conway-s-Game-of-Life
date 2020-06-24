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
    
    
    public func blinkerOscillation(isBlinking: Bool) {
        cells = Array(repeating: Cell(x: 0, y: 0, state: .dead), count: 625)
        cells[312].state = .alive
        
        if isBlinking {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                self.cells[311].state = .alive
                self.cells[313].state = .alive
                self.cells[311].state = .dead
                self.cells[313].state = .dead
                
                self.cells[287].state = .alive
                self.cells[337].state = .alive
                self.cells[287].state = .dead
                self.cells[337].state = .dead
                
                self.cells[311].state = .alive
                self.cells[313].state = .alive
                self.cells[311].state = .dead
                self.cells[313].state = .dead
                
                self.cells[287].state = .alive
                self.cells[337].state = .alive
                self.cells[287].state = .dead
                self.cells[337].state = .dead
            }

            
            
            
        }
        
    }
    
}
