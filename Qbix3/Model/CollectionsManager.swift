//
//  CollectionsManager.swift
//  Qbix3
//
//  Created by Matteo Radice on 18/01/2021.
//

import UIKit

struct CollectionsManager {
    func applyAttributes(cell: UICollectionViewCell, row: Int, collection: Int) -> UICollectionViewCell{
        if collection == 1 {
            let myCell = cell as! BoardCell
            myCell.backgroundColor = Board.boxes[row].originalAttributes.color
            return myCell
        }
        if collection == 2 {
            let myCell = cell as! BoardCell
            myCell.backgroundColor = Board.solution[row].originalAttributes.color
            return myCell
        }
        return cell
    }
}

