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
        let myCell = cell
        if collection == .board {
            myCell.backgroundColor = Board.boxes[row].originalAttributes.color
            return myCell
        }
        if collection == .solution {
            myCell.backgroundColor = Board.solution[row].originalAttributes.color
            return myCell
        }
        return cell
    }
}

