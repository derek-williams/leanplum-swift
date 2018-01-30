//
//  NewellAndSimonTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** Represents a single aspect of Newell and Simon's Tic-tac-toe strategy. */
protocol NewellAndSimonTactic {
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position?
}
