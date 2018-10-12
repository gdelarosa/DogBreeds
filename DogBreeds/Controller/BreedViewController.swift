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
import SDWebImage

class BreedViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var breedListTable: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    // MARK: - Properties
    var dogBreed: [Breed]!
    var dogImage: [Image]!
    let router = ApiRouter()
    var results: [String] = []
    var imageResults = [String]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        breedListTable.prefetchDataSource = self
        presentAnimation()
        requestFromApi()
        requestImages()

    }
    
    /// Presents animation when tableview is loaded
    func presentAnimation() {
        breedListTable.reloadData()
        let rotateAnimation = [AnimationType.random()]
        breedListTable.animate(animations: rotateAnimation)
    }
   
    /// Requesting data to be displayed on tableview.
    func requestFromApi() {
        router.requestBreeds { (data, error) in
            
            if let data = data {
                self.dogBreed = data
            } else {
                print("Error: \(String(describing: error))")
            }
            
            let array = self.dogBreed[0].message.keys.sorted()
            for type in array {
                self.results.append(type)
            }
            self.breedListTable.reloadData()
        }
    }
    
    /// Requesting Images to be displayed onto the collectionview
    func requestImages() {
        router.requestImages { (images, error) in
            
            if let imageData = images {
                self.dogImage = imageData
            } else {
                print("Error: \(String(describing: error))")
            }
           
            let imageArray = self.dogImage[0].message
            for imageType in imageArray {
                self.imageResults.append(imageType)
            }
            
            self.imageCollectionView.reloadData()
            self.loading.stopAnimating()
        }
    }

}

// MARK: - Table View Configuration
extension BreedViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "BREEDS"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BreedTableViewCell
        
        cell.breedName.text = results[indexPath.row]
        
        return cell
    }
    
    // MARK: - Enhancing smooth scrolling with the pre-fetching API protocol
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

// MARK: - Displaying random images of dogs in a collection view.
extension BreedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
     
        cell.randomImage.sd_setImage(with: URL(string: imageResults[indexPath.row]), placeholderImage: UIImage(named: ""))

        return cell
    }
}

