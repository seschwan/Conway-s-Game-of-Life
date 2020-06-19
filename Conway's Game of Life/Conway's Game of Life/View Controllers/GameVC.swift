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
    
    let cellArray = Array(repeating: 0, count: 625)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    
    
    
    @IBAction func playPauseBtnPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func stopBtnPressed(_ sender: UIBarButtonItem) {
        
        
    }
}

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        collectionCell.layer.backgroundColor = UIColor.systemRed.cgColor
        
        let individualCell = cellArray[indexPath.item]
        for cell in 0...individualCell {
            collectionCell.layer.backgroundColor = UIColor.systemBlue.cgColor
        }
        
        
        return collectionCell
    }
    
    
    
}
