//
//  ViewController.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let boardInitializer = BoardInitializer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Board.init(nOfRows: K.BoardSize.nOfRows, nOfColumns: K.BoardSize.nOfColumns, solutionLenght: K.BoardSize.solutionLenght)
        boardInitializer.colorBoard()
        boardInitializer.createSolution()
    }
}

