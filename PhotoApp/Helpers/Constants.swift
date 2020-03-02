//
//  Constants.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/18/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let tabBarController = "MainTabBarController"
        static let loginNavController = "LoginNavController"
        static let feedPhotoTableCellId = "PhotoCell"
        
    }
    
    struct Segue {
        
        static let profileViewController = "goToCreateProfile"
        
    }
    
    struct LocalStorage {
        
        static let storedUsername = "storedUsername"
        static let storedUserId = "storedUserId"
        
    }
}
