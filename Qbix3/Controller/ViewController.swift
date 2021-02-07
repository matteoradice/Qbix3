//
//  ViewController.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let boardInitializer = BoardInitializer()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let spacingBtwColumns:CGFloat = 5
    let spacingBtwRows:CGFloat = 5
    
    let itemsPerRow:CGFloat = CGFloat(K.BoardSize.nOfColumns)
    let itemsPerColumn:CGFloat = CGFloat(K.BoardSize.nOfRows)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardLayout = UICollectionViewFlowLayout()
        let solutionLayout = UICollectionViewFlowLayout()
        
        let boardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: boardLayout)
        let solutionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: solutionLayout)
        
        boardCollectionView.tag = 1
        solutionCollectionView.tag = 2
        
        createViews(collection: boardCollectionView)
        createViews(collection: solutionCollectionView)
                
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


//MARK: - Create programmatically collection views

extension ViewController {
    
    func createViews(collection: UICollectionView) {
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        collection.backgroundColor = .clear
        
        if collection.tag == 1 {
            collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -382).isActive = true
            collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
        else {
            collection.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
            collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Board.boxes.count == 0 {
            return 1
        }
        else {
            if collectionView.tag == 1 {
                return Board.boxes.count
            }
            else
            {
                return Board.solution.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionManager = CollectionsManager()
        if collectionView.tag == 2 {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.boardCell, for: indexPath) as! BoardCell
            cell = collectionManager.applyAttributes(cell: cell, row: indexPath.row, collection: collectionView.tag) as! BoardCell
            return cell
        } else {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.boardCell, for: indexPath) as! BoardCell
            cell = collectionManager.applyAttributes(cell: cell, row: indexPath.row, collection: collectionView.tag) as! BoardCell
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

}

//MARK: -UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBtwRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBtwColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var rows:CGFloat = 0
        var columns:CGFloat = 0
        
        if collectionView.tag == 1 {
            rows = CGFloat(Board.nOfRows)
            columns = CGFloat(Board.nOfColumns)
        } else {
            rows = 1
            columns = CGFloat(K.BoardSize.solutionLenght)
        }
        
        let visibileWidth:CGFloat = collectionView.visibleSize.width - sectionInsets.left - sectionInsets.right - (spacingBtwColumns * (columns - 1))
        let visibileHeight:CGFloat = collectionView.visibleSize.height - sectionInsets.top - sectionInsets.bottom
        
        let itemHeight = visibileHeight / rows
        let itemWidth = visibileWidth / columns
        
        let square = itemHeight <= itemWidth ? itemHeight : itemWidth
        
        print("**************************************")
        print("TAG \(collectionView.tag)")
        print("Total width \(collectionView.frame.width)")
        print("Visible Size width \(collectionView.visibleSize.width)")
        print("Visible Width \(visibileWidth)")
        print("Item Width \(square)")
        print("TOTAL WIDTH ITEMS \(square * columns)")
        print("+++++++++++++")
        print("Total height \(collectionView.frame.height)")
        print("Visible Size height \(collectionView.visibleSize.height)")
        print("Visible Height \(visibileHeight)")
        print("Item Height \(square)")
        print("TOTAL HEIGHT ITEMS \(square * rows)")
        
        return CGSize(width: square, height: square)
    }
        
}
