//
//  TheDogModel.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation

// MARK: - DogBreedsModelElement
struct DogBreedsModel: Codable {
    let weight, height: Weight?
    let id: Int?
    let name: String?
    let bredFor, breedGroup: String?
    let lifeSpan, temperament: String?
    let origin: String?
    let referenceImageID: String?
    let countryCode, description, history: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case countryCode = "country_code"
        case description, history
    }

}

// MARK: - Weight
struct Weight: Codable {
    let imperial, metric: String
}

typealias DogBreedsArray = [DogBreedsModel]
