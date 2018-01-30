//
//  EmptySideTacticTests.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/1/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import XCTest

class EmptySideTacticTests: XCTestCase {

    func test_choosePositionForMark_noSidesAreEmpty_returnsNil() {
        XCTAssertNil(EmptySideTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            " X ",
            "X X",
            " X ")))
    }
    
    func test_choosePositionForMark_topIsEmpty_returnsTop() {
        let position = (EmptySideTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            "   ",
            "X X",
            " X ")))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 1))
        }
        else {
            XCTFail("Did not detect that the top is empty.")
        }
    }
    
    func test_choosePositionForMark_rightIsEmpty_returnsRight() {
        let position = (EmptySideTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            " X ",
            "X  ",
            " X ")))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 2))
        }
        else {
            XCTFail("Did not detect that the right is empty.")
        }
    }
    
    func test_choosePositionForMark_bottomIsEmpty_returnsBottom() {
        let position = (EmptySideTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            " X ",
            "X X",
            "   ")))
        if let position = position {
            XCTAssertTrue(position == (row: 2, column: 1))
        }
        else {
            XCTFail("Did not detect that the bottom is empty.")
        }
    }
    
    func test_choosePositionForMark_leftIsEmpty_returnsLeft() {
        let position = (EmptySideTactic().choosePositionForMark(.X, onGameBoard: board3x3(
            " X ",
            "  X",
            " X ")))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 0))
        }
        else {
            XCTFail("Did not detect that the left is empty.")
        }
    }
}
