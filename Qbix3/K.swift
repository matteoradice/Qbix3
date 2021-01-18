//
//  K.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

struct K {
    struct BoardSize {
        static let nOfRows = 4
        static let nOfColumns = 4
        static let solutionLenght = 3
    }
    
    struct Attributes {
        static let colors:[UIColor] = [.green, .red, .blue, .black, .brown, .cyan, .magenta]
    }
    
    struct Cells {
        static let boardCell = "BoardCell"
        static let solutionCell = "SolutionCell"
    }
}
