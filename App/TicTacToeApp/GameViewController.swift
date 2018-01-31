//
//  RootViewController.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import UIKit
import TicTacToe
import SpriteKit
import Leanplum

/** The view controller that manages Tic-tac-toe gameplay. */
final class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBoardView.tappedEmptyPositionHandler = { [weak self] position in
            self?.handleTappedEmptyPosition(position)
        }
        
        gameBoardView.tappedFinishedGameBoardHandler = { [weak self] in
            self?.startPlayingGame()
        }
        
        
        startPlayingGame()
    }
    
    @IBAction fileprivate func handleRefreshButton(_ sender: AnyObject) {
        startPlayingGame()
    }
    
    fileprivate var game: Game?
    fileprivate var userStrategyX: UserStrategy?
    fileprivate var userStrategyO: UserStrategy?
    var gameLabel = LPVar.define("gameLabel", with: "LeanPlum")
    
    @IBOutlet fileprivate weak var gameBoardView: GameBoardView!
    
    @IBOutlet weak var titleBar: UINavigationItem!
    
    @IBAction fileprivate func switchTitle(sender: UIButton)
    {
         Leanplum.onVariablesChanged
         {
            self.titleBar.title = self.gameLabel?.stringValue()
         }
    }
    
    let powerUp = LPVar.define("powerUp", with: [
        "name": "Useless Powerup",
        "uselessMultiplier": 1.5])
    
    @IBOutlet weak var multiplierValue: UILabel!
    
    @IBOutlet weak var multiplierName: UILabel!
    
    @IBAction fileprivate func SwapDictionaryElement(sender: UIButton)
    {
        Leanplum.onVariablesChanged
        {
            self.multiplierName.text = self.powerUp?.object(forKey: "name") as! String?
            let newValue = (self.multiplierValue.text! as NSString).floatValue + (self.powerUp?.object(forKey: "uselessMultiplier") as! NSNumber).floatValue
            //print((self.powerUp?.object(forKey: "uselessMultiplier") as! NSNumber).floatValue.description)
            self.multiplierValue.text = newValue.description
        }
    }
}

// MARK: - Gameplay

private extension GameViewController {
    func startPlayingGame() {
        let gameBoard = GameBoard()
        gameBoardView.gameBoard = gameBoard
        
        userStrategyX = UserStrategy()
        userStrategyO = UserStrategy()
        
        let
        xStrategy = userStrategyX!,
        oStrategy = userStrategyO!
        
        game = Game(gameBoard: gameBoard, xStrategy: xStrategy, oStrategy: oStrategy)
        game!.startPlayingWithCompletionHandler { [weak self] outcome in
            self?.gameBoardView.winningPositions = outcome.winningPositions
        }
    }
    
    func handleTappedEmptyPosition(_ position: GameBoard.Position) {
        if !reportChosenPosition(position, forUserStrategy: userStrategyX) {
            reportChosenPosition(position, forUserStrategy: userStrategyO)
        }
        gameBoardView.refreshBoardState()
    }
    
    func reportChosenPosition(_ position: GameBoard.Position, forUserStrategy userStrategy: UserStrategy?) -> Bool {
        guard let userStrategy = userStrategy, userStrategy.isWaitingToReportChosenPosition else {
            return false
        }
        
        userStrategy.reportChosenPosition(position)
        return true
    }
}
