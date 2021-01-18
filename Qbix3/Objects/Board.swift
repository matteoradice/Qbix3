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
    static var gamePlay = GamePlay()
    
    static var nOfColumns:Int = K.BoardSize.nOfColumns
    static var nOfRows:Int = K.BoardSize.nOfRows
}

