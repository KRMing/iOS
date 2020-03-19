//
//  LoginViewController.swift
//  Mingstagram
//
//  Created by 이민건 on 3/13/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // create a firebase auth ui object
        let authUI = FUIAuth.defaultAuthUI()
        
        // check that it isn't nil
        guard authUI != nil else {
            
            print("authUI initialization failed")
            
            return
        }
        
        // set the login view controller as the delegate
        authUI!.delegate = self
        authUI!.providers = [FUIEmailAuth()]
        
        // create a firebase auth pre build UI View Controller
        let authViewController = authUI!.authViewController()
        
        // present it 
        present(authViewController, animated: true, completion: nil)
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // check if an error occured
        guard error == nil else {
            
            print("error occured in didSignInWith authUI")
            
            return
        }
        
        // get the user && check if user is nil
        if let user = authDataResult?.user {
            
//            user.uid do something here
        }
    }
}
