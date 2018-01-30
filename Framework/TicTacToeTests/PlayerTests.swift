//
//  PlayerTests.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/28/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {

    func test_choosePositionWithCompletionHandler_strategyChoosesCenterPosition_choosesCenterPosition() {
        let
        board  = GameBoard(),
        center = GameBoard.Position(row: 1, column: 1),
        script = ScriptedStrategy(positions: [center]),
        player = Player(mark: .X, gameBoard: board, strategy: script)
        
        // Use an expectation to avoid assuming the completion handler is immediately invoked.
        let expectation = expectationWithDescription("Player chooses center position")
        player.choosePositionWithCompletionHandler { position in
            XCTAssertEqual(position.row, center.row)
            XCTAssertEqual(position.column, center.column)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
