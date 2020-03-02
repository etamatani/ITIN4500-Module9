//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/22/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import SDWebImage


class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPhoto(_ photo:Photo) {
        
        usernameLabel.text = photo.byUsername
        dateLabel.text = photo.date
        
        if let urlString = photo.url {
            
            let url = URL(string: urlString)
            
            guard url != nil else {
                // Couldn't create url object
                return
            }
            
            photoImageView.sd_setImage(with: url) { (image, error, cacheType, url) in
                
                self.photoImageView.image = image
                
            }
        }
        
    }
}
