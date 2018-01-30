//
//  GameTests.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/28/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import XCTest

class GameTests: XCTestCase {
    
    func test_startPlayingWithCompletionHandler_playerXWins_invokesCompletionHandlerCorrectly() {
        let
        expectation = expectationWithDescription("Player X wins"),
        board = GameBoard(),
        (xStrategy, oStrategy) = ScriptedStrategy.strategiesFrom3x3TextDiagram(
            "XOO",
            "X  ",
            "X  "),
        game = Game(gameBoard: board, xStrategy: xStrategy, oStrategy: oStrategy)
        game.startPlayingWithCompletionHandler { outcome in
            // Make sure all of the scripted plays were made.
            XCTAssertTrue(xStrategy.isFinished)
            XCTAssertTrue(oStrategy.isFinished)
            
            // The exact position values are tested by OutcomeAnalyzerTests.
            XCTAssertEqual(outcome.winner, Winner.PlayerX)
            XCTAssertNotNil(outcome.winningPositions)
            XCTAssertEqual(outcome.winningPositions?.count, 3)
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func test_startPlayingWithCompletionHandler_playerOWins_invokesCompletionHandlerCorrectly() {
        let
        expectation = expectationWithDescription("Player O wins"),
        board = GameBoard(),
        (xStrategy, oStrategy) = ScriptedStrategy.strategiesFrom3x3TextDiagram(
            "X  ",
            "OOO",
            "X X"),
        game = Game(gameBoard: board, xStrategy: xStrategy, oStrategy: oStrategy)
        game.startPlayingWithCompletionHandler { outcome in
            // Make sure all of the scripted plays were made.
            XCTAssertTrue(xStrategy.isFinished)
            XCTAssertTrue(oStrategy.isFinished)
            
            // The exact position values are tested by OutcomeAnalyzerTests.
            XCTAssertEqual(outcome.winner, Winner.PlayerO)
            XCTAssertNotNil(outcome.winningPositions)
            XCTAssertEqual(outcome.winningPositions?.count, 3)
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func test_startPlayingWithCompletionHandler_tied_invokesCompletionHandlerCorrectly() {
        let
        expectation = expectationWithDescription("Neither player wins"),
        board = GameBoard(),
        (xStrategy, oStrategy) = ScriptedStrategy.strategiesFrom3x3TextDiagram(
            "XOX",
            "XOO",
            "OXX"),
        game = Game(gameBoard: board, xStrategy: xStrategy, oStrategy: oStrategy)
        game.startPlayingWithCompletionHandler { outcome in
            // Make sure all of the scripted plays were made.
            XCTAssertTrue(xStrategy.isFinished)
            XCTAssertTrue(oStrategy.isFinished)
            
            // Neither player should have won (the game was tied).
            XCTAssertNil(outcome.winner)
            XCTAssertNil(outcome.winningPositions)
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    func test_startPlayingWithCompletionHandler_bothOpponentsAreAI_gameIsTied() {
        let
        expectation = expectationWithDescription("Neither player wins"),
        board = GameBoard(),
        xStrategy = NewellAndSimonStrategy(),
        oStrategy = NewellAndSimonStrategy(),
        game = Game(gameBoard: board, xStrategy: xStrategy, oStrategy: oStrategy)
        game.startPlayingWithCompletionHandler { outcome in            
            // Neither player should have won (the game was tied).
            XCTAssertNil(outcome.winner)
            XCTAssertNil(outcome.winningPositions)
            
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
