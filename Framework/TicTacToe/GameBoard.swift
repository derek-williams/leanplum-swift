//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/27/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** The possible states for a position on a GameBoard. */
public enum Mark {
    case x, o
    
    func opponentMark() -> Mark {
        switch self {
        case .x: return .o
        case .o: return .x
        }
    }
}

/** 
 Represents the state of a Tic-tac-toe game.
 Each position on the board can be empty or marked.
 A position is identified by zero-based row/column indexes.
 */
public final class GameBoard {
    
    public typealias Position = (row: Int, column: Int)
    
    public enum Diagonal {
        case topLeftToBottomRight, bottomLeftToTopRight
        
        static func allValues() -> [Diagonal] {
            return [.topLeftToBottomRight, .bottomLeftToTopRight]
        }
    }
    
    public convenience init(dimension: Int = 3) {
        assert(dimension >= 3)
        
        let
        emptyRow = [Mark?](repeating: nil, count: dimension),
        allMarks = [[Mark?]](repeating: emptyRow, count: dimension)
        
        self.init(dimension: dimension, marks: allMarks)
    }
    
    fileprivate init(dimension: Int, marks: [[Mark?]]) {
        self.dimension = dimension
        self.dimensionIndexes = [Int](0..<dimension)
        self.marks = marks
    }
    
    public let dimension: Int

    public var emptyPositions: [Position] {
        return positions.filter(isEmptyAtPosition)
    }
    
    public var marksAndPositions: [(mark: Mark, position: Position)] {
        return positions.flatMap { position in
            if let mark = markAtPosition(position) {
                return (mark, position)
            }
            else {
                return nil
            }
        }
    }
    
    
    
    // MARK: - Non-public stored properties
    
    internal let dimensionIndexes: [Int]
    
    internal var marks: [[Mark?]] // internal for unit test access
    
    fileprivate lazy var positions: [Position] = {
        self.dimensionIndexes.flatMap { row -> [Position] in
            let
            rows = [Int](repeating: row, count: self.dimension),
            cols = self.dimensionIndexes
            return Array(zip(rows, cols))
        }
    }()
}



// MARK: - Internal methods

internal extension GameBoard {
    func cloneWithMark(_ mark: Mark, atPosition position: Position) -> GameBoard {
        let clone = GameBoard(dimension: dimension, marks: [[Mark?]](marks))
        clone.putMark(mark, atPosition: position)
        return clone
    }
    
    func isEmptyAtPosition(_ position: Position) -> Bool {
        return markAtPosition(position) == nil
    }
    
    func marksInRow(_ row: Int) -> [Mark?] {
        return positionsForRow(row).map(markAtPosition)
    }
    
    func marksInColumn(_ column: Int) -> [Mark?] {
        return positionsForColumn(column).map(markAtPosition)
    }
    
    func marksInDiagonal(_ diagonal: Diagonal) -> [Mark?] {
        return positionsForDiagonal(diagonal).map(markAtPosition)
    }
    
    func positionsForRow(_ row: Int) -> [Position] {
        return dimensionIndexes.map { (row: row, column: $0) }
    }
    
    func positionsForColumn(_ column: Int) -> [Position] {
        return dimensionIndexes.map { (row: $0, column: column) }
    }
    
    func positionsForDiagonal(_ diagonal: Diagonal) -> [Position] {
        let rows = dimensionIndexes, columns = dimensionIndexes
        switch diagonal {
        case .topLeftToBottomRight: return Array(zip(rows, columns))
        case .bottomLeftToTopRight: return Array(zip(rows.reversed(), columns))
        }
    }
    
    func putMark(_ mark: Mark, atPosition position: Position) {
        assertPosition(position)
        assert(isEmptyAtPosition(position))
        marks[position.row][position.column] = mark
    }
}



// MARK: - Private methods

private extension GameBoard {
    func assertIndex(_ index: Int) {
        assert(-1 < index && index < dimension)
    }
    
    func assertPosition(_ position: Position) {
        assertIndex(position.row)
        assertIndex(position.column)
    }
    
    func markAtPosition(_ position: Position) -> Mark? {
        assertPosition(position)
        return marks[position.row][position.column]
    }
}



// MARK: - Debugging

internal extension GameBoard {
    var textRepresentation: String {
        return marks
            .map(stringWithMarks)
            .joined(separator: "\n")
    }
    
    fileprivate func stringWithMarks(_ marks: [Mark?]) -> String {
        return marks
            .map(glyphForMark)
            .joined(separator: "")
    }
    
    fileprivate func glyphForMark(_ mark: Mark?) -> String {
        switch mark {
        case Mark.x?: return "X"
        case Mark.o?: return "O"
        case nil:     return "•"
        }
    }
}
