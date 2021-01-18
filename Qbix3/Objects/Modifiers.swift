//
//  Modifiers.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import UIKit

enum ClickStatus {
    case notClicked
    case correct
    case incorrect
}

struct Modifiers {
    
    var inSolution:Bool = false
    var clicked:Bool = false
    var correct:ClickStatus = .notClicked
    
}
