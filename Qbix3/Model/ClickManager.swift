//
//  ClickManager.swift
//  Qbix3
//
//  Created by Matteo Radice on 18/01/2021.
//

import UIKit

struct ClickManager {
    
    typealias ControlSolution = (_ check: String) -> ()
    
    func manageClick(box: Box, controlSolution: ControlSolution) {
    
        //1. Is it the first move?
        if Board.gamePlay.clickedStreak == nil || Board.gamePlay.clickedStreak?.count == 0 {
            //2. Is the box correct?
            if box.originalAttributes == Board.solution[0].originalAttributes {
                box.modifiers.clicked = true
                box.modifiers.correct = .correct
                if (Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: true))) == nil {
                    Board.gamePlay.clickedStreak = [(box: box, move: 0, correct: true)]
                }
            }
            //2. Is the box incorrect?
            else {
                box.modifiers.clicked = true
                box.modifiers.correct = .incorrect
                if (Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: false))) == nil {
                    Board.gamePlay.clickedStreak = [(box: box, move: 0, correct: false)]
                }
            }
        }
        // 1. Isn't it the first move?
        else {
            // 1b. Is the box a non-clicked one?
            if box.modifiers.clicked == false {
                // 1c. Am I in a positive streak?
                if (Board.gamePlay.clickedStreak?.last?.correct)! == true {
                    // 2. Is the box correct?
                    let move = (Board.gamePlay.clickedStreak?.last?.move)!
                    if box.originalAttributes == Board.solution[move + 1].originalAttributes {
                        box.modifiers.clicked = true
                        box.modifiers.correct = .correct
                        Board.gamePlay.clickedStreak?.append((box: box, move: move + 1, correct: true))
                    }
                    // 2. Is the box incorrect?
                    else {
                        box.modifiers.clicked = true
                        box.modifiers.correct = .incorrect
                        Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: false))
                    }
                }
                // 1c. Am I in a negative streak?
                else {
                    // 2. Is the box correct?
                    if box.originalAttributes == Board.solution[0].originalAttributes {
                        box.modifiers.clicked = true
                        box.modifiers.correct = .correct
                        Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: true))
                    }
                    // 2. Is the box incorrect?
                    else {
                        box.modifiers.clicked = true
                        box.modifiers.correct = .incorrect
                        Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: false))
                    }
                }
            }
            // 1b. Check if the box has already been selected
            else {
                box.modifiers.clicked = false
                box.modifiers.correct = .notClicked
                Board.gamePlay.clickedStreak?.removeLast()
            }
        }
        
        // Have you achieved the solution?
        if let check = Board.gamePlay.clickedStreak?.last?.move {
            if check == K.BoardSize.solutionLenght - 1 {
                controlSolution("COMPLETED")
            } else { controlSolution("NOT YET THERE") }
        }
    }
}
