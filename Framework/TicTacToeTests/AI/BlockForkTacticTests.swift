//
//  BlockForkTacticTests.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/3/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import XCTest

class BlockForkTacticTests: XCTestCase {

    func test_choosePositionForMark_emptyBoard_returnsNil() {
        XCTAssertNil(BlockForkTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "   ",
            "   ",
            "   ")))
    }
    
    func test_choosePositionForMark_opponentCannotForkHorizontal_returnsNil() {
        XCTAssertNil(BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "   ",
            "XOX",
            "   ")))
    }
    
    func test_choosePositionForMark_opponentCannotForkVertical_returnsNil() {
        XCTAssertNil(BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            " X ",
            " O ",
            " X ")))
    }
    
    func test_choosePositionForMark_opponentCanForkInTopLeftOrBottomRightCorner_returnsOffensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "  X",
            " O ",
            "X  "))
        if let position = position {
            // Cannot put O in a corner because that would force X to create a fork when blocking it.
            XCTAssertTrue(
                position == (row: 0, column: 1) ||
                position == (row: 1, column: 0) ||
                position == (row: 1, column: 2) ||
                position == (row: 2, column: 1))
        }
        else {
            XCTFail("Did not detect opponent's fork and offensive position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkInBottomLeftOrTopRightCorner_returnsOffensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "X  ",
            " O ",
            "  X"))
        if let position = position {
            // Cannot put O in a corner because that would force X to create a fork when blocking it.
            XCTAssertTrue(
                position == (row: 0, column: 1) ||
                position == (row: 1, column: 0) ||
                position == (row: 1, column: 2) ||
                position == (row: 2, column: 1))
        }
        else {
            XCTFail("Did not detect opponent's fork and offensive position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkInMiddleColumnAndBottomRow_returnsOffensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "XO ",
            "  X",
            "O  "))
        if let position = position {
            XCTAssertTrue(
                position == (row: 0, column: 2) ||
                position == (row: 1, column: 1) ||
                position == (row: 2, column: 1))
        }
        else {
            XCTFail("Did not detect opponent's fork and offensive position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkAndPlayerCannotForceOpponentToBlock_returnsDefensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "X  ",
            "   ",
            "OX "))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 1))
        }
        else {
            XCTFail("Did not detect opponent's fork position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkToTheRightAndPlayerCannotForceOpponentToBlock_returnsDefensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "X  ",
            "O  ",
            "X  "))
        if let position = position {
            XCTAssertTrue(
                position == (row: 0, column: 2) ||
                position == (row: 1, column: 1) ||
                position == (row: 2, column: 2))
        }
        else {
            XCTFail("Did not detect opponent's fork position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkBelowAndPlayerCannotForceOpponentToBlock_returnsDefensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            "XOX",
            "   ",
            "   "))
        if let position = position {
            XCTAssertTrue(
                position == (row: 1, column: 1) ||
                position == (row: 2, column: 0) ||
                position == (row: 2, column: 2))
        }
        else {
            XCTFail("Did not detect opponent's fork position.")
        }
    }
    
    func test_choosePositionForMark_opponentCanForkInManyWays_returnsOffensivePosition() {
        let position = BlockForkTactic().choosePositionForMark(.O, onGameBoard: board3x3(
            // Cannot put O in (0, 1) because X would go in (0, 2) to fork.
            // Cannot put O in (1, 0) because X would go in (2, 0) to fork.
            // Cannot put O in (1, 2) because X would go in (2, 0) to fork.
            // Cannot put O in (2, 1) because X would go in (1, 2) or (0, 2) to fork.
            // Must put O in (0, 2) or (2, 0)
            "O  ",
            " X ",
            "  X"))
        if let position = position {
            XCTAssertTrue(
                position == (row: 0, column: 2) ||
                position == (row: 2, column: 0))
        }
        else {
            XCTFail("Did not block opponent's fork position.")
        }
    }
}
