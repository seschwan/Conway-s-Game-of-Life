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
    
    //let cellArray = Array(repeating: 0, count: 625)
    
    var world = World(size: 25)
    
    var generationCount = 0 {
        didSet {
            generationLbl.text = String(generationCount)
        }
    }
    
    var startStop = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        generationLbl.text = String(generationCount)

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
    
    
    @IBAction func playPauseBtnPressed(_ sender: UIBarButtonItem) {
        startStop.toggle()
        autoRun(run: startStop)
    }
    
    @IBAction func stopBtnPressed(_ sender: UIBarButtonItem) {
        startStop = false
        world = World(size: 25)
        world.updateCells()
        collectionView.reloadData()
        generationCount = 0
        
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
        
        
        
        return collectionCell
    }
    
    
    
    
    
}
