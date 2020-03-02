//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/17/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import FirebaseUI


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Create a firebase auth ui object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
            
        // Set the login view controller as the delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
            
        // Present it
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
            
        
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check if an error occured
        guard error == nil else {
            print("Error has happend")
            return
        }
        
        // Get the user
        let user = authDataResult?.user
        
        // Check if user is nil
        if let user = user {
            
            // This means that we have a user, now check if they have a profile
            UserService.getUserProfile(userId: user.uid) { (u) in
                
                if u == nil {
                    // No profile, go to profile controller
                    self.performSegue(withIdentifier: Constants.Segue.profileViewController, sender: self)
                }
                else {
                    
                    // Save the logged in uset to local storage
                    LocalStorageService.saveCurrentUser(user: u!)
                    
                    // This user has a profile, to tab controller
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
        }
    }
    
}
