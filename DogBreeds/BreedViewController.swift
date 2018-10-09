//
//  ViewController.swift
//  DogBreeds
//
//  Created by Gina De La Rosa on 10/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Create a tableview to display dog breeds using the api,
//  https://dog.ceo/api/breeds/list/all

import UIKit

class BreedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dogBreed: [Breed]!
    
    @IBOutlet weak var dogBreedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Configuration
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell 
    }

}

