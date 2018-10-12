//
//  Router.swift
//  DogBreeds
//
//  Created by Gina De La Rosa on 10/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import Foundation
import Alamofire

class ApiRouter {

    /// Requesting the breed types from the URL while also decoding an instance of Breed type from a JSON object.
    func requestBreeds(completion: @escaping([Breed]?, Error?) -> Void) {
        
        let URL = "https://dog.ceo/api/breeds/list/all"
        
        Alamofire.request(URL).responseJSON { response in
            let decoder = JSONDecoder()
            if let result = try?
                decoder.decode(Breed.self, from: response.data!) {
                completion([result], nil)
            } else {
                print("Unable to decode data")
            }
        }
    }
    
    /// Requesting random breed images.
    func requestImages(completion: @escaping([Image]?, Error?) -> Void) {
        
        let URL = "https://dog.ceo/api/breeds/image/random/10"
        
        Alamofire.request(URL).responseJSON { response in
            let decoder = JSONDecoder()
            if let result = try?
                decoder.decode(Image.self, from: response.data!) {
                completion([result], nil)
            } else {
                print("Unable to decode data")
            }
        }
    }
    
}
