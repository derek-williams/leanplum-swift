//
//  GameBoardView.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import TicTacToe
import UIKit

/** Displays the lines and marks of a Tic-tac-toe game. */
final class GameBoardView: UIView {
    
    var gameBoard: GameBoard? {
        didSet {
            _layout = nil
            _renderer = nil
            winningPositions = nil
        }
    }
    
    var winningPositions: [GameBoard.Position]? {
        didSet { refreshBoardState() }
    }
    
    func refreshBoardState() {
        setNeedsDisplay()
    }
    
    var tappedEmptyPositionHandler: ((GameBoard.Position) -> Void)?
    
    var tappedFinishedGameBoardHandler: (() -> Void)?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if gameBoard != nil {
            handleTouchesEnded(touches)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if gameBoard != nil {
            renderer.renderWithWinningPositions(winningPositions)
        }
    }
    
    fileprivate var _renderer: GameBoardRenderer?
    fileprivate var renderer: GameBoardRenderer {
        assert(gameBoard != nil)
        if _renderer == nil {
            // By the time a renderer is needed, this view's graphics context should exist.
            let context = UIGraphicsGetCurrentContext()!
            _renderer = GameBoardRenderer(context: context, gameBoard: gameBoard!, layout: layout)
        }
        return _renderer!
    }
    
    fileprivate var _layout: GameBoardLayout?
    fileprivate var layout: GameBoardLayout {
        assert(gameBoard != nil)
        if _layout == nil {
            // By the time a layout is needed, this view's frame should reflect its actual size.
            _layout = GameBoardLayout(frame: frame, marksPerAxis: gameBoard!.dimension)
        }
        return _layout!
    }
}



// MARK: - Touch handling

private extension GameBoardView {
    func handleTouchesEnded(_ touches: Set<UITouch>) {
        if isGameFinished {
            reportTapOnFinishedGameBoard()
        }
        else if let touch = touches.first, let emptyPosition = emptyPositionFromTouch(touch) {
            reportTapOnEmptyPosition(emptyPosition)
        }
    }
    
    var isGameFinished: Bool {
        let
        wasWon  = winningPositions != nil,
        wasTied = gameBoard?.emptyPositions.count == 0
        return wasWon || wasTied
    }
    
    func emptyPositionFromTouch(_ touch: UITouch) -> GameBoard.Position? {
        guard let gameBoard = gameBoard else { return nil }
        
        let
        touchLocation  = touch.location(in: self),
        emptyPositions = gameBoard.emptyPositions,
        emptyCellRects = layout.cellRectsAtPositions(emptyPositions)
        
        return zip(emptyPositions, emptyCellRects)
            .flatMap { (position, cellRect) in cellRect.contains(touchLocation) ? position : nil }
            .first
    }
    
    func reportTapOnFinishedGameBoard() {
        guard let tappedFinishedGameBoardHandler = tappedFinishedGameBoardHandler else { return }
        tappedFinishedGameBoardHandler()
    }
    
    func reportTapOnEmptyPosition(_ position: GameBoard.Position) {
        guard let tappedEmptyPositionHandler = tappedEmptyPositionHandler else { return }
        tappedEmptyPositionHandler(position)
    }
}
