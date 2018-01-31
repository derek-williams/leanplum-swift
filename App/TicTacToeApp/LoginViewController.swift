//
//  LoginViewController.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/30/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//
import UIKit
import Foundation
import SpriteKit
import Leanplum

final class LoginViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(sender: UIButton)
    {
        //present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tictactoe") as UIViewController, animated: true, completion: nil)
        
        if(Leanplum.hasStarted())
        {
            //Leanplum.setUserId()
            performSegue(withIdentifier: "main", sender: sender)
            print("Trying to change scenes")
        }
        else
        {
          print("not intialized try again soon")
        }
    }
}
