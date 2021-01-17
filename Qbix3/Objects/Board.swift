//
//  Board.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

class Board {
    
    static var boxes = [Box]()
    static var solution = [Box]()
    
    init(nOfRows: Int, nOfColumns: Int, solutionLenght: Int) {
        var id:Int = 0
        for x in 0..<nOfRows {
            for y in 0..<nOfColumns {
                let myBox = Box()
                myBox.coordinates = (x, y)
                myBox.id = id
                id += 1
                Board.boxes.append(myBox)
            }
        }
        for _ in 0..<solutionLenght {
            let myBox = Box()
            Board.solution.append(myBox)
        }
    }
}

