//
//  CenterTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #5 in Newell and Simon's strategy.
 If the center position is empty, returns the center position.
 */
struct CenterTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        assert(gameBoard.dimension == 3)
        
        let center = GameBoard.Position(row: 1, column: 1)
        return gameBoard.isEmptyAtPosition(center) ? center : nil
    }
}
