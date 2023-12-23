//
//  BreedImageModel.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation

// MARK: - BreedImageModel
struct BreedImageModel: Codable {
    let id: String?
    let url: String?
    let breeds: DogBreedsArray
    let width, height: Int?
}
