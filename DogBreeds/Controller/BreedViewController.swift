//
//  ViewController.swift
//  DogBreeds
//
//  Created by Gina De La Rosa on 10/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Create a tableview to display dog breeds using the api,
//  

import UIKit
import ViewAnimator

class BreedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var breedListTable: UITableView!
    
    // MARK: - Properties
    var dogBreed: [Breed]!
    let router = ApiRouter()
    var results: [String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        breedListTable.prefetchDataSource = self
        presentAnimation()
        requestFromApi()
        
    }
    
    /// Presents animation when tableview is loaded
    func presentAnimation() {
        breedListTable.reloadData()
        let rotateAnimation = [AnimationType.random()]
        breedListTable.animate(animations: rotateAnimation)
    }
   
    /// Requesting data from server
    func requestFromApi() {
        router.requestBreeds { (data, error) in
            if let data = data {
                self.dogBreed = data
            }
            
            let array = Array(self.dogBreed)[0].message.keys.sorted()
            
            for type in array {
                self.results.append(type)
            }
            self.breedListTable.reloadData()
        }
    }

    // MARK: - Table View Configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BreedTableViewCell
        
        cell.breedName.text = results[indexPath.row]
        
        return cell 
    }

}

// MARK: - Enhancing smooth scrolling with the pre-fetching API protocol
extension BreedViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            print ( "Prefetching Rows: \( item.row)" )
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            print ( "Prefetching Cancelled: \( item.row)" )
        }
    }

}

