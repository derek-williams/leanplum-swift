//
//  BlockTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #2 in Newell and Simon's strategy.
 If the opponent can play one mark to win, returns the position to block/occupy.
 */
struct BlockTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        return WinTactic().choosePositionForMark(mark.opponentMark(), onGameBoard: gameBoard)
    }
}
