//
//  TicTacToeStrategy.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/28/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** Describes an object capable of deciding where to put the next mark on a GameBoard. */
public protocol TicTacToeStrategy {
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard, completionHandler: @escaping (GameBoard.Position) -> Void)
}

public func createArtificialIntelligenceStrategy() -> TicTacToeStrategy {
    return NewellAndSimonStrategy()
}
