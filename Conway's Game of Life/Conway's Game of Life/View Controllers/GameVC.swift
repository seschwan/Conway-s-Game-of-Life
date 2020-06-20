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
    
    let world = World(size: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    
    
    
    @IBAction func playPauseBtnPressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            for _ in 0...5 {
                self.world.updateCells()
            }
        }
        
        collectionView.reloadData()
        
       
        
    }
    
    @IBAction func stopBtnPressed(_ sender: UIBarButtonItem) {
        
        
    }
}

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.world.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let singleCell = world.cells[indexPath.item]
        
        //self.world.updateCells()
        
        for _ in world.cells {
           
            if singleCell.state == State.alive {
                collectionCell.layer.backgroundColor = UIColor.systemRed.cgColor
            } else {
                collectionCell.layer.backgroundColor = UIColor.systemGray.cgColor
            }
        }
        
        
        
        return collectionCell
    }
    
    
    
    
    
}
