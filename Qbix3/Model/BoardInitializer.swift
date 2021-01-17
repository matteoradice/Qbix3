//
//  StartUpEngine.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import Foundation

struct BoardInitializer {
    
    func colorBoard() {
        for i in Board.boxes {
            let colorSelection:Int = K.Attributes.colors.count
            i.originalAttributes.color = K.Attributes.colors[Int.random(in: 0..<colorSelection)]
        }
    }
    
    
    func createSolution() {
        
        enum Direction {
            case horizontal
            case vertical
        }
        
        var move:Int = 0
        var row:Int = 0
        var column:Int = 0
        var direction:Direction = .horizontal
        
        var comparisonArrray:[Box] = []
        var selectedBox:Int = 0
        
        repeat {
            for i in Board.boxes {
                switch direction {
                case .horizontal:
                    if i.coordinates.row == row {comparisonArrray.append(i)}
                case .vertical:
                    if i.coordinates.column == column {comparisonArrray.append(i)}
                }
            }
                
            selectedBox = comparisonArrray[Int.random(in: 0..<comparisonArrray.count)].id
            comparisonArrray = []
        
            if Board.boxes[selectedBox].modifiers.inSolution == false {
                Board.boxes[selectedBox].modifiers.inSolution = true
                Board.solution[move] = Board.boxes[selectedBox]
                row = Board.solution[move].coordinates.row
                column = Board.solution[move].coordinates.column
                if direction == .horizontal {direction = .vertical} else {direction = .horizontal}
                move += 1
            }
            
        } while move < K.BoardSize.solutionLenght
    }
}
