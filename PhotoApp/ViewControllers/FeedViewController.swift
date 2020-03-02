//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Eisuke Tamatani on 1/17/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // Create and add the refresh control
        addRefreshControl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve and display the photos
        PhotoService.getPhotos { (photos) in
            
            self.photos = photos
            self.tableView.reloadData()
        }
    }
    
    func addRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshInitiated(refechControl:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refreshInitiated(refechControl:UIRefreshControl) {
        
        // Call the photo service retrieve photos
        PhotoService.getPhotos { (photos) in
            
            self.photos = photos
            self.tableView.reloadData()
            refechControl.endRefreshing()
        }
        
    }
    
}

extension FeedViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a photo cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.feedPhotoTableCellId, for: indexPath) as! PhotoCell
        
        // Get the photofor this row
        let photo = photos[indexPath.row]
        
        // Set the details for the cell
        cell.setPhoto(photo)
        
        return cell
    }
    
}
