//
//  OppositeCornerTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/1/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #6 in Newell and Simon's strategy.
 If the opponent is in a corner and the opposite corner (along the diagonal) is empty, returns the opposite corner position.
 */
struct OppositeCornerTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        assert(gameBoard.dimension == 3)
        
        return GameBoard.Diagonal
            .allValues()
            .flatMap { choosePositionInDiagonal($0, forMark: mark, gameBoard: gameBoard) }
            .first
    }
    
    fileprivate func choosePositionInDiagonal(_ diagonal: GameBoard.Diagonal, forMark mark: Mark, gameBoard: GameBoard) -> GameBoard.Position? {
        let
        marks     = gameBoard.marksInDiagonal(diagonal),
        positions = gameBoard.positionsForDiagonal(diagonal),
        (leftMark, rightMark) = (marks[0],     marks[2]),
        (leftPos,  rightPos)  = (positions[0], positions[2])
        
        let opponent = mark.opponentMark()
        
        switch (leftMark, rightMark) {
        case (opponent?, nil): return rightPos
        case (nil, opponent?): return leftPos
        default:               return nil
        }
    }
}
