//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/21/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            
            // Then the add tab is selected
            // Show the action sheet
            showActionSheet()
        }
    }
    
    func showActionSheet() {
        
        // Create action sheet
        var actionSheet = UIAlertController(title: "Add Photo", message: "Select a source", preferredStyle: .actionSheet)
        
        // Create actions
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                
                self.showImagePicker(type: .camera)
                
            }
            actionSheet.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            
                self.showImagePicker(type: .photoLibrary)
            
            }
            
            actionSheet.addAction(libraryAction)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        // Present action sheet
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func showImagePicker(type: UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        
        // Present it
        present(imagePicker, animated: true, completion: nil)
    }
    
    func goToFeed() {
        // Change to the first tab
        selectedIndex = 0
    }
    
}

extension MainTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // User cancelled dismiss image picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // Successfuly got the image now upload it

            // Get a referemce to the camera VC
            let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                
                cameraVC.savePhoto(image: selectedImage)
                
            }
            
        }
        
        // Dismiss the picker
        picker.dismiss(animated: true, completion: nil)
    }
}
