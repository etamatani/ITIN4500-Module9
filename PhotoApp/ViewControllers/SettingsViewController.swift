//
//  SettingsViewController.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/17/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutTapped(_ sender: UIButton) {
        
        do {
            
            // Sign put using firebase auth methods
            try Auth.auth().signOut()
            
            // Clear local storage
            LocalStorageService.clearCurrentUser()
            
            // Change the window to show the login screen
            let loginVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginNavController)
            
            view.window?.rootViewController = loginVC
            view.window?.makeKeyAndVisible()
            
        }
        catch {
            // Error signing out
            print("Couldn't sign out")
        }
        
        
    }
    
}
