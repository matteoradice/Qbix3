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
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let itemsPerRow:CGFloat = CGFloat(K.BoardSize.nOfColumns)
    let itemsPerColumn:CGFloat = CGFloat(K.BoardSize.nOfRows)
    
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
        clickManager.manageClick(box: Board.boxes[indexPath.row]) { (check) in
            print(check)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalWaste = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - horizontalWaste
        let widthPerItem = availableWidth / itemsPerRow

        let verticalWaste = sectionInsets.top * (itemsPerColumn + 1)
        let availableHeight = view.frame.height - verticalWaste
        let heightPerItem = availableHeight / itemsPerColumn
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
        

}

