//
//  LocalStorageService.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/18/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    static func saveCurrentUser(user:PhotoUser) {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(user.userId, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(user.username, forKey: Constants.LocalStorage.storedUsername)
        
    }
    
    static func loadCurrentUser() -> PhotoUser? {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        let username = defaults.value(forKey: Constants.LocalStorage.storedUsername) as? String
        let userId = defaults.value(forKey: Constants.LocalStorage.storedUserId) as? String
        
        // Couldn't get a user, return nil
        guard username != nil || userId != nil else{
            return nil
        }
        
        let u = PhotoUser(username: username!, userId: userId!)
        return u
        
    }
    
    static func clearCurrentUser() {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: Constants.LocalStorage.storedUsername)
        defaults.set(nil, forKey: Constants.LocalStorage.storedUserId)
        
    }
}
