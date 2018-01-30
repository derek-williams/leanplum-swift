//
//  EmptySideTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/1/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #8 in Newell and Simon's strategy.
 If the a side position is empty, returns the side position.
 */
struct EmptySideTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        let
        allSides   = sidePositionsForGameBoard(gameBoard),
        emptySides = allSides.filter(gameBoard.isEmptyAtPosition)
        return emptySides.first
    }
    
    fileprivate func sidePositionsForGameBoard(_ gameBoard: GameBoard) -> [GameBoard.Position] {
        assert(gameBoard.dimension == 3)
        
        let
        top    = GameBoard.Position(row: 0, column: 1),
        right  = GameBoard.Position(row: 1, column: 2),
        bottom = GameBoard.Position(row: 2, column: 1),
        left   = GameBoard.Position(row: 1, column: 0)
        return [top, right, bottom, left]
    }
}
