//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/17/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CameraViewController: UIViewController {

    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        // Hide and configure the progress ring
        progressRing.alpha = 0
        progressRing.value = 0
        progressRing.maxValue = 100
        progressRing.innerRingColor = .green
        
        // Hide the label and button
        doneLabel.alpha = 0
        doneButton.alpha = 0
    }
    
    func savePhoto(image:UIImage) {
        
        PhotoService.savePhoto(image: image) { (pct) in
            
            // Update the progress ring
            self.progressRing.alpha = 1
            self.progressRing.startProgress(to: CGFloat(pct), duration: 1)
            
            if pct == 100 {
                
                self.doneButton.alpha = 1
                self.doneLabel.alpha = 1
                
            }
        }
        
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        // Go to photos tab
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            // Call the goToFeed method
            tabBarVC.goToFeed()
            
        }
    }
    
}
