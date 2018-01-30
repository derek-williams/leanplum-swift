//
//  Game.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/28/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** Orchestrates gameplay between two players. */
public final class Game {
    
    public typealias CompletionHandler = (Outcome) -> Void
    
    public init(gameBoard: GameBoard, xStrategy: TicTacToeStrategy, oStrategy: TicTacToeStrategy) {
        self.gameBoard = gameBoard
        self.outcomeAnalyst = OutcomeAnalyst(gameBoard: gameBoard)
        self.playerX = Player(mark: .x, gameBoard: gameBoard, strategy: xStrategy)
        self.playerO = Player(mark: .o, gameBoard: gameBoard, strategy: oStrategy)
    }
    
    public func startPlayingWithCompletionHandler(_ completionHandler: @escaping CompletionHandler) {
        assert(self.completionHandler == nil, "Cannot start the same Game twice.")
        self.completionHandler = completionHandler
        currentPlayer = playerX
    }
    
    
    
    // MARK: - Non-public stored properties
    
    fileprivate var currentPlayer: Player? {
        didSet {
            currentPlayer?.choosePositionWithCompletionHandler(processChosenPosition)
        }
    }
    
    fileprivate var completionHandler: CompletionHandler!
    fileprivate let gameBoard: GameBoard
    fileprivate let outcomeAnalyst: OutcomeAnalyst
    fileprivate let playerO: Player
    fileprivate let playerX: Player
}



// MARK: - Private methods

private extension Game {
    func processChosenPosition(_ position: GameBoard.Position) {
        guard let currentPlayer = currentPlayer else {
            assertionFailure("Why was a position chosen if there is no current player?")
            return
        }
        
        gameBoard.putMark(currentPlayer.mark, atPosition: position)
        
        log(position)
        
        if let outcome = outcomeAnalyst.checkForOutcome() {
            finishWithOutcome(outcome)
        }
        else {
            switchCurrentPlayer()
        }
    }
    
    func log(_ position: GameBoard.Position) {
        print("--- \(currentPlayer!.mark) played (\(position.row), \(position.column)) ---\n\(gameBoard.textRepresentation)\n")
    }
    
    func finishWithOutcome(_ outcome: Outcome) {
        completionHandler(outcome)
        currentPlayer = nil
    }
    
    func switchCurrentPlayer() {
        let xIsCurrent = (currentPlayer!.mark == .x)
        currentPlayer = xIsCurrent ? playerO : playerX
    }
}
