//
//  CollectionsManager.swift
//  Qbix3
//
//  Created by Matteo Radice on 18/01/2021.
//

import UIKit

enum Collections {
    case board
    case solution
}

struct CollectionsManager {
    func applyAttributes(cell: UICollectionViewCell, row: Int, collection: Collections) -> UICollectionViewCell{
        if collection == .board {
            let myCell = cell as! BoardCell
            myCell.backgroundColor = Board.boxes[row].originalAttributes.color
            myCell.labelInCell.text = Board.boxes[row].originalAttributes.letter
            return myCell
        }
        if collection == .solution {
            let myCell = cell as! BoardCell
            myCell.backgroundColor = Board.solution[row].originalAttributes.color
            myCell.labelInCell.text = Board.boxes[row].originalAttributes.letter
            return myCell
        }
        return cell
    }
}

