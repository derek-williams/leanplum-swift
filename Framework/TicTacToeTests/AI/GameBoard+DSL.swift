//
//  GameBoard+DSL.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

func board3x3(diagramLines: String...) -> GameBoard {
    let diagram = diagramLines.joinWithSeparator("")
    return GameBoard.gameBoardFrom3x3TextDiagram(diagram)
}

/** Supports a simple domain-specific language for creating a GameBoard. */
extension GameBoard {
    static func gameBoardFrom3x3TextDiagram(textDiagram: String) -> GameBoard {
        assert(textDiagram.characters.count == 9)
        
        let
        board   = GameBoard(),
        symbols = textDiagram.characters.map { String($0).uppercaseString },
        marks   = symbols.map(markFromSymbol)
        for (index, mark) in marks.enumerate() where mark != nil {
            let position = GameBoard.Position(row: index / 3, column: index % 3)
            board.putMark(mark!, atPosition: position)
        }
        return board
    }
    
    private static func markFromSymbol(symbol: String) -> Mark? {
        switch symbol {
        case "X": return .X
        case "O": return .O
        default:  return nil
        }
    }
}
