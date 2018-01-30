//
//  UserStrategy.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation
import TicTacToe

/** A Tic-tac-toe strategy that allows a person to decide where to put marks on a game board. */
final class UserStrategy: TicTacToeStrategy {
    func choosePositionForMark(_: Mark, onGameBoard _: GameBoard, completionHandler: @escaping (GameBoard.Position) -> Void) {
        self.reportChosenPositionClosure = completionHandler
    }
    
    func reportChosenPosition(_ position: GameBoard.Position) {
        if let reportChosenPositionClosure = reportChosenPositionClosure {
            self.reportChosenPositionClosure = nil
            reportChosenPositionClosure(position)
        }
    }
    
    var isWaitingToReportChosenPosition: Bool {
        return reportChosenPositionClosure != nil
    }
    
    fileprivate var reportChosenPositionClosure: ((GameBoard.Position) -> Void)?
}
