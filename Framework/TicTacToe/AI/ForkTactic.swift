//
//  ForkTactic.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/2/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/**
 Tactic #3 in Newell and Simon's strategy.
 If the player can play one mark to create two ways to win on their next turn, returns that mark's position.
 */
struct ForkTactic: NewellAndSimonTactic {
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> GameBoard.Position? {
        assert(gameBoard.dimension == 3)
        
        return findForkPositionsForMark(mark, onGameBoard: gameBoard).first
    }
    
    internal func findForkPositionsForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard) -> [GameBoard.Position] {
        let
        indexes       = gameBoard.dimensionIndexes,
        diagonals     = GameBoard.Diagonal.allValues(),
        rowInfos      = indexes.map   { Info(marks: gameBoard.marksInRow($0),      positions: gameBoard.positionsForRow($0))      },
        columnInfos   = indexes.map   { Info(marks: gameBoard.marksInColumn($0),   positions: gameBoard.positionsForColumn($0))   },
        diagonalInfos = diagonals.map { Info(marks: gameBoard.marksInDiagonal($0), positions: gameBoard.positionsForDiagonal($0)) }
        
        let
        forkableRowInfos      = rowInfos.filter      { $0.isForkableWithMark(mark) },
        forkableColumnInfos   = columnInfos.filter   { $0.isForkableWithMark(mark) },
        forkableDiagonalInfos = diagonalInfos.filter { $0.isForkableWithMark(mark) }
        
        return [
            findForkPositionsWithInfos(forkableRowInfos,      andOtherInfos: forkableColumnInfos  ),
            findForkPositionsWithInfos(forkableRowInfos,      andOtherInfos: forkableDiagonalInfos),
            findForkPositionsWithInfos(forkableColumnInfos,   andOtherInfos: forkableDiagonalInfos),
            findForkPositionsWithInfos(forkableDiagonalInfos, andOtherInfos: forkableDiagonalInfos)]
            .flatMap { $0 }
    }
    
    fileprivate func findForkPositionsWithInfos(_ infos: [Info], andOtherInfos otherInfos: [Info]) -> [GameBoard.Position] {
        return infos.flatMap { self.findForkPositionsWithInfo($0, andOtherInfos: otherInfos) }
    }
    
    fileprivate func findForkPositionsWithInfo(_ info: Info, andOtherInfos otherInfos: [Info]) -> [GameBoard.Position] {
        return otherInfos
            .filter  { info.markedPosition != $0.markedPosition  }
            .flatMap { info.findIntersectingPositionWithInfo($0) }
    }
}

private struct Info {
    let marks: [Mark?]
    let positions: [GameBoard.Position]
    
    func isForkableWithMark(_ mark: Mark) -> Bool {
        let
        nonNilMarks = marks.flatMap { $0 },
        onlyOneMark = nonNilMarks.count == 1,
        isRightMark = nonNilMarks.first == mark
        return onlyOneMark && isRightMark
    }
    
    var markedPosition: GameBoard.Position {
        let markIndex = marks.index { $0 != nil }
        return positions[markIndex!]
    }
    
    func findIntersectingPositionWithInfo(_ info: Info) -> GameBoard.Position? {
        return positions.filter { info.containsPosition($0) }.first
    }
    
    func containsPosition(_ position: GameBoard.Position) -> Bool {
        return positions.contains { $0 == position }
    }
}
