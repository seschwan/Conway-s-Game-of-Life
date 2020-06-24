//
//  GameVC.swift
//  Conway's Game of Life
//
//  Created by Seschwan on 6/18/20.
//  Copyright © 2020 Seschwan. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var generationLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var playBtn: UIBarButtonItem!
    
    let generator = UINotificationFeedbackGenerator()
    
    //let cellArray = Array(repeating: 0, count: 625)
    
    var world = World(size: 25)
    
    var generationCount = 0 {
        didSet {
            generationLbl.text = String(generationCount)
        }
    }
    
    var startStop = Bool()
    var isBlinking = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        generationLbl.text = String(generationCount)
        generator.prepare()

    }
    
    func autoRun(run: Bool) {
        if startStop {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.world.updateCells()
                self.collectionView.reloadData()
                self.generationCount += 1
                self.autoRun(run: run)
            }
        }
    }
    
    
    // MARK: - Button Actions
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        startStop = false
        world = World(size: 25)
        world.updateCells()
        collectionView.reloadData()
        generationCount = 0
        generator.notificationOccurred(.success)
    }
    
    @IBAction func playPauseBtnPressed(_ sender: UIBarButtonItem) {
        startStop.toggle()
        autoRun(run: startStop)
        generator.notificationOccurred(.success)
    }
    
    @IBAction func stopBtnPressed(_ sender: UIBarButtonItem) {
        startStop = false
        world = World(size: 25)
        world.updateCells()
        collectionView.reloadData()
        generationCount = 0
        generator.notificationOccurred(.success)
        
    }
    
    @IBAction func stepOneTimeBtnPressed(_ sender: UIBarButtonItem) {
        startStop = false
        world.updateCells()
        collectionView.reloadData()
        generationCount += 1
        generator.notificationOccurred(.success)
    }
    
    // MARK: - Oscillators
    
    @IBAction func blinkerBtnPressed(_ sender: UIBarButtonItem) {
        isBlinking = true
        //world.blinkerOscillation(isBlinking: isBlinking)
        blinkerSetup(run: isBlinking)
        
        collectionView.reloadData()
        
    }
    // Make 2 functions for H and V and then recursively call each one.
    // Make an H line with cells and then just updateCells
    
    func blinkerSetup(run: Bool) {
        world.cells = Array(repeating: Cell(x: 0, y: 0, state: .dead), count: 625)
        world.cells[312].state = .alive
        
        if isBlinking {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                self.world.cells[311].state = .alive
                self.world.cells[313].state = .alive
            
                self.world.cells[311].state = .dead
                self.world.cells[313].state = .dead
            
                
                self.world.cells[287].state = .alive
                self.world.cells[337].state = .alive
            
                self.world.cells[287].state = .dead
                self.world.cells[337].state = .dead
            
                
                self.world.cells[311].state = .alive
                self.world.cells[313].state = .alive
            
                self.world.cells[311].state = .dead
                self.world.cells[313].state = .dead
            
                
                self.world.cells[287].state = .alive
                self.world.cells[337].state = .alive
            
                self.world.cells[287].state = .dead
                self.world.cells[337].state = .dead
                
                self.collectionView.reloadData()
            }
            
            
            
            
        }
            
        
        
        
//        world.cells = Array(repeating: Cell(x: 0, y: 0, state: .dead), count: 625)
//        world.cells[311].state = .alive
//        world.cells[313].state = .alive
//
//        world.cells[312].state = .alive
//
//        world.cells[287].state = .alive
//        world.cells[337].state = .alive
        
//        isBlinking = true
//        world.blinkerOscillation(isBlinking: isBlinking)
        //collectionView.reloadData()
       
    }
    
    
}

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.world.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let singleCell = world.cells[indexPath.item]
        
        collectionCell.layer.backgroundColor = singleCell.state == .alive ? UIColor.systemRed.cgColor : UIColor.systemGray.cgColor
        collectionCell.layer.cornerRadius = collectionCell.bounds.height / 4
        
        
        return collectionCell
    }
    
    
    
    
    
}
