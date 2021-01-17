//
//  Box.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

class Box {

    // Identificators of the box coordinates in the board
    var coordinates:(row: Int, column: Int) = (0,0)
    var id = 0
    
    // Content and attributes of the box
    var originalAttributes = Attributes()
    
    // Characteristics of the box modified during gameplay
    var modifiers = Modifiers()
    
}
