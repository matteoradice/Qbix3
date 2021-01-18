//
//  GamePlay.swift
//  Qbix3
//
//  Created by Matteo Radice on 18/01/2021.
//

import Foundation

enum Direction {
    case horizontal
    case vertical
}

struct GamePlay {
    
    var direction:Direction = .horizontal
    var clickedStreak:[(box: Box, move: Int, correct: Bool)]?
    
}

