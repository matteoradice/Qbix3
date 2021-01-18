//
//  StartUpEngine.swift
//  Qbix3
//
//  Created by Matteo Radice on 17/01/2021.
//

import Foundation

struct BoardInitializer {
    
    typealias completionHandler = (_ success: Bool) -> ()
    
    func initializeBoard(nOfRows: Int = K.BoardSize.nOfRows, nOfColumns: Int = K.BoardSize.nOfColumns, solutionLenght: Int = K.BoardSize.solutionLenght, completionHandler: completionHandler) {
        createBoard(nOfRows: nOfRows, nOfColumns: nOfColumns, solutionLenght: solutionLenght) { (result) in
            colorBoard { (result) in
                createSolution { (result) in
                    completionHandler(true)
                }
            }
        }
    }
    
    func createBoard(nOfRows: Int, nOfColumns: Int, solutionLenght: Int, completionHandler: completionHandler) {
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
        completionHandler(true)
    }
    
    
    func colorBoard(completionHandler: completionHandler) {
        for i in Board.boxes {
            let colorSelection:Int = K.Attributes.colors.count
            i.originalAttributes.color = K.Attributes.colors[Int.random(in: 0..<colorSelection)]
        }
        completionHandler(true)
    }
    
    
    func createSolution(completionHandler: completionHandler) {
        var move:Int = 0
        var row:Int = 0
        var column:Int = 0
        var comparisonArray:[Box] = []
        var selectedBox:Int = 0
        repeat {
            for i in Board.boxes {
                switch Board.gamePlay.direction {
                case .horizontal:
                    if i.coordinates.row == row {comparisonArray.append(i)}
                case .vertical:
                    if i.coordinates.column == column {comparisonArray.append(i)}
                }
            }
            selectedBox = comparisonArray[Int.random(in: 0..<comparisonArray.count)].id
            comparisonArray = []
            
            if Board.boxes[selectedBox].modifiers.inSolution == false {
                Board.boxes[selectedBox].modifiers.inSolution = true
                Board.solution[move] = Board.boxes[selectedBox]
                row = Board.solution[move].coordinates.row
                column = Board.solution[move].coordinates.column
                if Board.gamePlay.direction == .horizontal {
                    Board.gamePlay.direction = .vertical
                } else {Board.gamePlay.direction = .horizontal}
                move += 1
            }
        } while move < K.BoardSize.solutionLenght
        completionHandler(true)
    }
}
