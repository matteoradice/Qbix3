//
//  ViewController.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let boardInitializer = BoardInitializer()
    
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var solutionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardCollectionView.delegate = self
        solutionCollectionView.delegate = self
        boardCollectionView.dataSource = self
        solutionCollectionView.dataSource = self
                
        let nibCell = UINib(nibName: K.Cells.boardCell, bundle: nil)
        boardCollectionView.register(nibCell, forCellWithReuseIdentifier: K.Cells.boardCell)
        solutionCollectionView.register(nibCell, forCellWithReuseIdentifier: K.Cells.boardCell)
        
        boardInitializer.initializeBoard { (result) in
            if result == true {
                boardCollectionView.reloadData()
                solutionCollectionView.reloadData()
            }
            else {
                print("Error in creating the board")
            }
        }
    }
}

//MARK: - Collection views delegates

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Defines the number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Is board not yet populated?
        if Board.boxes.count == 0 {
            return 1
        }
        // Is board populated?
        else {
            if collectionView == boardCollectionView {
                return Board.boxes.count
            }
            else
            {
                return Board.solution.count
            }
        }
    }
    
    // Defines the content of the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionManager = CollectionsManager()
        if collectionView == boardCollectionView {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.boardCell, for: indexPath) as! BoardCell
            cell = collectionManager.applyAttributes(cell: cell, row: indexPath.row, collection: .board) as! BoardCell
            return cell
        } else {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.boardCell, for: indexPath) as! BoardCell
            cell = collectionManager.applyAttributes(cell: cell, row: indexPath.row, collection: .solution) as! BoardCell
            return cell
        }
    }

    // Interacts with clicks
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let clickManager = ClickManager()
        clickManager.manageClick(box: Board.boxes[indexPath.row])
    }
    
}

