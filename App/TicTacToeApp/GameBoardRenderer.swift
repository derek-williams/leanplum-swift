//
//  GameBoardRenderer.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import TicTacToe
import UIKit

/** Draws a game board on the screen. */
final class GameBoardRenderer {
    
    init(context: CGContext, gameBoard: GameBoard, layout: GameBoardLayout) {
        self.context = context
        self.gameBoard = gameBoard
        self.layout = layout
    }
    
    func renderWithWinningPositions(_ winningPositions: [GameBoard.Position]?) {
        renderBorder()
        renderPlatform()
        renderGridLines()
        renderMarks()
        if let winningPositions = winningPositions {
            renderLineThroughWinningPositions(winningPositions)
        }
    }
    
    fileprivate let context: CGContext
    fileprivate let gameBoard: GameBoard
    fileprivate let layout: GameBoardLayout
}



// MARK: - Rendering routines

private extension GameBoardRenderer {
    func renderBorder() {
        context.strokeRect(layout.outerBorderRect, color: UIColor.outerBorder, width: Thickness.outerBorder)
        context.strokeRect(layout.innerBorderRect, color: UIColor.innerBorder, width: Thickness.innerBorder)
    }
    
    func renderPlatform() {
        context.fillRect(layout.platformRect, color: UIColor.platform)
    }
    
    func renderGridLines() {
        layout.gridLines.forEach {
            context.strokeLineFrom($0.startPoint, to: $0.endPoint, color: UIColor.gridLine, width: Thickness.gridLine, lineCap: .butt)
        }
    }
    
    func renderMarks() {
        gameBoard.marksAndPositions
            .map     { (mark, position) in (mark, layout.markRectAtPosition(position)) }
            .forEach { (mark, markRect) in renderMark(mark, inRect: markRect) }
    }
    
    func renderMark(_ mark: Mark, inRect rect: CGRect) {
        switch mark {
        case .x: renderX(inRect: rect)
        case .o: renderO(inRect: rect)
        }
    }
    
    func renderX(inRect rect: CGRect) {
        context.strokeLineFrom(rect.topLeft, to: rect.bottomRight, color: UIColor.markX, width: Thickness.mark, lineCap: .round)
        context.strokeLineFrom(rect.bottomLeft, to: rect.topRight, color: UIColor.markX, width: Thickness.mark, lineCap: .round)
    }
    
    func renderO(inRect rect: CGRect) {
        context.strokeEllipseInRect(rect, color: UIColor.markO, width: Thickness.mark)
    }
    
    func renderLineThroughWinningPositions(_ winningPositions: [GameBoard.Position]) {
        let (startPoint, endPoint) = layout.lineThroughWinningPositions(winningPositions)
        context.strokeLineFrom(startPoint, to: endPoint, color: UIColor.winningLine, width: Thickness.winningLine, lineCap: .round)
    }
}



// MARK: - Element colors

private extension UIColor {
    static let
    gridLine    = UIColor.darkGray,
    innerBorder = UIColor.darkGray,
    markO       = UIColor.blue,
    markX       = UIColor.green,
    outerBorder = UIColor.white,
    platform    = UIColor.white,
    winningLine = UIColor.red
}
