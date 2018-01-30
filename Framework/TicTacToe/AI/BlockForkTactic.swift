//
//  BlockForkTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/3/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #4 in Newell and Simon's strategy.
 If the opponent can play one mark to create two ways to win on their next turn,
 returns a position that forces the opponent to block on their next turn,
 or, if no offensive play is possible, returns the position to block the fork.
 */
struct BlockForkTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        assert(gameBoard.dimension == 3)
        
        // This tactic is only applicable when the opponent can create a fork.
        guard let forkPosition = findForkPositionForMark(mark.opponentMark(), onGameBoard: gameBoard) else {
            return nil
        }
        
        // An offensive position is 'safe' if it does not enable the opponent to create a fork by blocking it.
        let safeOffensivePosition = findSafeOffensivePositionForMark(mark, onGameBoard: gameBoard)
        return safeOffensivePosition ?? forkPosition
    }
    
    fileprivate func findForkPositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        return ForkTactic().choosePositionForMark(mark, onGameBoard: gameBoard)
    }
    
    fileprivate func findSafeOffensivePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        return gameBoard.emptyPositions
            .filter { isSafeOffensivePosition($0, forMark: mark, onGameBoard: gameBoard) }
            .first
    }
    
    fileprivate func isSafeOffensivePosition(_ offensivePosition: GameBoard.Position, forMark mark: Mark, onGameBoard gameBoard: GameBoard) -> Bool {
        let possibleGameBoard = gameBoard.cloneWithMark(mark, atPosition: offensivePosition)
        
        guard let winningPosition = findWinningPositionForMark(mark, onGameBoard: possibleGameBoard) else {
            return false
        }
        
        if wouldCreateForkForMark(mark.opponentMark(), byBlockingPosition: winningPosition, onGameBoard: possibleGameBoard) {
            return false
        }
        
        return true
    }
    
    fileprivate func findWinningPositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        return WinTactic().choosePositionForMark(mark, onGameBoard: gameBoard)
    }
    
    fileprivate func wouldCreateForkForMark(_ mark: Mark, byBlockingPosition blockPosition: GameBoard.Position, onGameBoard gameBoard: GameBoard) -> Bool {
        let
        forkPositions  = ForkTactic().findForkPositionsForMark(mark, onGameBoard: gameBoard),
        isForkingBlock = forkPositions.contains { $0 == blockPosition }
        return isForkingBlock
    }
}
