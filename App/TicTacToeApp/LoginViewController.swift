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

final class LoginViewController : UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var userName: UITextField!
    
    @IBAction func login(sender: UIButton)
    {
        //present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tictactoe") as UIViewController, animated: true, completion: nil)
        
        if(Leanplum.hasStarted())
        {
            print("leanplum has started")
            if(userName.hasText && userName.text != "UserName")
            {
                print("username has text and it doesn't equal username")
                Leanplum.setUserId(userName.text)
                
                //if the username exists it gets
            }
            else
            {
                print("username hasnt been set")
                //userid will be
            }
            performSegue(withIdentifier: "main", sender: sender)
            userName.text = "UserName"
            print("Trying to change scenes")
        }
        else
        {
          print("not intialized try again soon")
        }
    }
}
