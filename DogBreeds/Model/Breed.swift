//
//  DogBreed.swift
//  DogBreeds
//
//  Created by Gina De La Rosa on 10/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.

import Foundation

// MARK: - Using codable to convert between JSON and Swift data types

/// Will hold dog breed data
struct Breed : Codable {
    let status: String
    let message: [String: [String]]
    
}



