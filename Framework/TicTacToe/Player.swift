//
//  Player.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/28/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** Represents a Tic-tac-toe contestant, either human or computer. */
internal final class Player {
    
    init(mark: Mark, gameBoard: GameBoard, strategy: TicTacToeStrategy) {
        self.mark = mark
        self.gameBoard = gameBoard
        self.strategy = strategy
    }
    
    let mark: Mark
    
    func choosePositionWithCompletionHandler(_ completionHandler: @escaping (GameBoard.Position) -> Void) {
        strategy.choosePositionForMark(mark, onGameBoard: gameBoard, completionHandler: completionHandler)
    }

    fileprivate let gameBoard: GameBoard
    fileprivate let strategy: TicTacToeStrategy
}
