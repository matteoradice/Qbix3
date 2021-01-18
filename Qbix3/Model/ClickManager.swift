//
//  ClickManager.swift
//  Qbix3
//
//  Created by Matteo Radice on 18/01/2021.
//

import UIKit

struct ClickManager {
    
    func manageClick(box: Box) {
        //1. Is it the first move?
        if Board.gamePlay.clickedStreak == nil {
            //2. Is the box correct?
            if box.originalAttributes == Board.solution[0].originalAttributes {
                box.modifiers.clicked = true
                box.modifiers.correct = .correct
                Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: true))
            }
            //2. Is the box incorrect?
            else {
                box.modifiers.clicked = true
                box.modifiers.correct = .incorrect
                Board.gamePlay.clickedStreak?.append((box: box, move: 0, correct: false))
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
    }
}
