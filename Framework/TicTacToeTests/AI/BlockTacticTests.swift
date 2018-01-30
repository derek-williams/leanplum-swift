//
//  BlockTacticTests.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import XCTest

class BlockTacticTests: XCTestCase {
    
    func test_choosePositionForMark_cannotWin_returnsNil() {
        XCTAssertNil(BlockTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "X O",
            "O X",
            "X  ")))
    }
    
    func test_choosePositionForMark_opponentCanWinInRow_returnsPositionInRow() {
        let position = BlockTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "XX ",
            "O  ",
            "X O"))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 2))
        }
        else {
            XCTFail("Did not detect opponent's winning row.")
        }
    }
    
    func test_choosePositionForMark_opponentCanWinInColumn_returnsPositionInColumn() {
        let position = BlockTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            " XO",
            "XO ",
            "X  "))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 0))
        }
        else {
            XCTFail("Did not detect opponent's winning column.")
        }
    }
    
    func test_choosePositionForMark_opponentCanWinInTopLeftToBottomRightDiagonal_returnsPositionInDiagonal() {
        let position = BlockTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "O X",
            "X  ",
            "  O"))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 1))
        }
        else {
            XCTFail("Did not detect opponent's winning diagonal.")
        }
    }
    
    func test_choosePositionForMark_opponentCanWinInBottomLeftToTopRightDiagonal_returnsPositionInDiagonal() {
        let position = BlockTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "X  ",
            "XOO",
            "O X"))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 2))
        }
        else {
            XCTFail("Did not detect winning diagonal.")
        }
    }
}
