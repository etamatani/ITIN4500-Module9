//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/21/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class PhotoService {
    
    static func getPhotos(completion: @escaping([Photo]) -> Void ) -> Void {
        
        // Getting a reference to the database
        let dbRef = Database.database().reference()
        
        // Make the db call
        dbRef.child("photos").observeSingleEvent(of: .value) { (snapshot) in
            
            // Declare an array to hold the photos
            var retrievedPhotos = [Photo]()
            
            // Get the list of snapshots
            let snapshots = snapshot.children.allObjects as? [DataSnapshot]
            
            if let snapshots = snapshots {
                
                // Loop through each snapshot and parse out the photos
                for snap in snapshots {
                    
                    // Try to create a photo from a snapshot
                    let p = Photo(snapshot: snap)
                    
                    // If successful, then add it to our array
                    if p != nil {
                        retrievedPhotos.insert(p!, at: 0)
                    }
                    
                }
                
            }
            
            // After parsing the snapshots, call the completion closure
            completion(retrievedPhotos)
            
        }
        
    }
    
    static func savePhoto(image: UIImage, progressUpdate: @escaping (Double) -> Void) {
        
        // Get data representation of the image
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            print("Couldn't turn the image into data")
            return
        }
        
        // Get a storage reference
        let userid = Auth.auth().currentUser!.uid
        let filename = UUID().uuidString
        
        let ref = Storage.storage().reference().child("images/\(userid)/\(filename).jpg")
        
        // Upload the photo
        let uploadTask = ref.putData(photoData!, metadata: nil) { (metadata, error) in
            
            if error != nil {
                // An error during upload pccurred
            }
            else {
                // Upload was successful, now create a darabase entry
                self.createPhotoDatabaseEntry(ref: ref)
            }
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            
            let percentage:Double = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount) * 100.0
            
            progressUpdate(percentage)
        }
    }
    
    private static func createPhotoDatabaseEntry(ref:StorageReference) {
        
        // Get a download url for the photo
        ref.downloadURL { (url, error) in
            if error != nil {
                // Couldn't retrieve the url
                return
            }
            else {
                
                // Get the meta data for the db entry
                
                // User
                let user = LocalStorageService.loadCurrentUser()
                
                guard user != nil else {
                    return
                }
                
                // Data
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                let dateString = dateFormatter.string(from: Date())
                
                // Create photo data
                let photoData = ["byId": user!.userId!, "date":dateString, "url":url!.absoluteString]
                
                // Write a database entry
                let dbRef = Database.database().reference().child("photos").childByAutoId()
                
                dbRef.setValue(photoData) { (error, dbRef) in
                    if error != nil {
                        // There was an error in writing the database entry
                    }
                    else {
                        // Database entry for the photo was written
                        return
                    }
                }
                
            }
        }
        
        
    }
    
}
