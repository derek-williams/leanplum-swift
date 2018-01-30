//
//  GameBoardLayout.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import TicTacToe
import UIKit

/** Calculates sizes and positions used to render a game board. */
final class GameBoardLayout {
    
    typealias Line = (startPoint: CGPoint, endPoint: CGPoint)
    
    init(frame: CGRect, marksPerAxis: Int) {
        self.frame = frame
        self.marksPerAxis = marksPerAxis
    }
    
    lazy var outerBorderRect: CGRect = {
        let
        width  = self.frame.width,
        height = self.frame.height,
        length = min(width, height) - (Thickness.platformMargin * 2),
        origin = CGPoint(x: width/2 - length/2, y: height/2 - length/2),
        size   = CGSize(width: length, height: length)
        return CGRect(origin: origin, size: size)
    }()
    
    lazy var innerBorderRect: CGRect = {
        return self.outerBorderRect.insetBy(Thickness.outerBorder)
    }()
    
    lazy var platformRect: CGRect = {
        return self.innerBorderRect.insetBy(Thickness.innerBorder)
    }()
    
    lazy var gridLines: [Line] = {
        let
        cellLength    = self.platformRect.width / CGFloat(self.marksPerAxis),
        lineNumbers   = 1..<self.marksPerAxis,
        verticalLines = lineNumbers.map { lineNumber -> Line in
            let x = self.platformRect.minX + CGFloat(lineNumber) * cellLength
            return Line(
                startPoint: CGPoint(x: x, y: self.platformRect.minY),
                endPoint:   CGPoint(x: x, y: self.platformRect.maxY))
        },
        horizontalLines = lineNumbers.map { lineNumber -> Line in
            let y = self.platformRect.minY + CGFloat(lineNumber) * cellLength
            return Line(
                startPoint: CGPoint(x: self.platformRect.minX, y: y),
                endPoint:   CGPoint(x: self.platformRect.maxX, y: y))
        }
        return verticalLines + horizontalLines
    }()
    
    func cellRectsAtPositions(_ positions: [GameBoard.Position]) -> [CGRect] {
        return positions.map(cellRectAtPosition)
    }
    
    fileprivate func cellRectAtPosition(_ position: GameBoard.Position) -> CGRect {
        let
        length = platformRect.width / CGFloat(marksPerAxis),
        left   = platformRect.minX + CGFloat(position.column) * length,
        top    = platformRect.minY + CGFloat(position.row) * length
        return CGRect(x: left, y: top, width: length, height: length)
    }
    
    func markRectAtPosition(_ position: GameBoard.Position) -> CGRect {
        let cellRect = cellRectAtPosition(position)
        return cellRect.insetBy(Thickness.gridLine/2 + Thickness.markMargin)
    }

    func lineThroughWinningPositions(_ winningPositions: [GameBoard.Position]) -> Line {
        let
        cellRects   = cellRectsAtPositions(winningPositions),
        startRect   = cellRects.first!,
        endRect     = cellRects.last!,
        orientation = winningLineOrientationForStartRect(startRect, endRect: endRect),
        startPoint  = startPointForRect(startRect, winningLineOrientation: orientation),
        endPoint    = endPointForRect(endRect, winningLineOrientation: orientation)
        return (startPoint, endPoint)
    }
    
    fileprivate enum WinningLineOrientation {
        case horizontal, vertical, topLeftToBottomRight, bottomLeftToTopRight
    }
    
    fileprivate func winningLineOrientationForStartRect(_ startRect: CGRect, endRect: CGRect) -> WinningLineOrientation {
        let
        x1 = Int(startRect.minX), x2 = Int(endRect.minX),
        y1 = Int(startRect.minY), y2 = Int(endRect.minY)
        if x1 == x2 { return .vertical }
        if y1 == y2 { return .horizontal }
        if y1 <  y2 { return .topLeftToBottomRight }
        return .bottomLeftToTopRight
    }
    
    fileprivate func startPointForRect(_ rect: CGRect, winningLineOrientation: WinningLineOrientation) -> CGPoint {
        let winningRect = rect.insetBy(Thickness.winningLineInset)
        switch winningLineOrientation {
        case .horizontal:           return winningRect.centerLeft
        case .vertical:             return winningRect.topCenter
        case .topLeftToBottomRight: return winningRect.topLeft
        case .bottomLeftToTopRight: return winningRect.bottomLeft
        }
    }
    
    fileprivate func endPointForRect(_ rect: CGRect, winningLineOrientation: WinningLineOrientation) -> CGPoint {
        let winningRect = rect.insetBy(Thickness.winningLineInset)
        switch winningLineOrientation {
        case .horizontal:           return winningRect.centerRight
        case .vertical:             return winningRect.bottomCenter
        case .topLeftToBottomRight: return winningRect.bottomRight
        case .bottomLeftToTopRight: return winningRect.topRight
        }
    }
    
    fileprivate let frame: CGRect
    fileprivate let marksPerAxis: Int
}
