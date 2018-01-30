//
//  NewellAndSimonStrategy.swift
//  TicTacToe
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import Foundation

/** 
 An intelligent agent which implements Newell and Simon's Tic-tac-toe strategy for a 3x3 game board.
 For more details, refer to strategy.pdf.
 */
final class NewellAndSimonStrategy: TicTacToeStrategy {
    
    init(tactics: [NewellAndSimonTactic] = [
        WinTactic(),
        BlockTactic(),
        ForkTactic(),
        BlockForkTactic(),
        CenterTactic(),
        OppositeCornerTactic(),
        EmptyCornerTactic(),
        EmptySideTactic()
        ]) {
        self.tactics = tactics
    }
    
    func choosePositionForMark(_ mark: Mark, onGameBoard gameBoard: GameBoard, completionHandler: @escaping (GameBoard.Position) -> Void) {
        assert(gameBoard.dimension == 3)
        
        let position = tactics.reduce(nil) { (position, tactic) in
            position ?? tactic.choosePositionForMark(mark, onGameBoard: gameBoard)
        }
        
        completionHandler(position!)
    }
    
    fileprivate let tactics: [NewellAndSimonTactic]
}
