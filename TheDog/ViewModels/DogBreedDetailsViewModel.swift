//
//  DogBreedDetailsViewModel.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation
import UIKit

class DogBreedDetailsViewModel {
    var dogBreed:DogBreedsModel?
    var imageURL:String = ""
    convenience init(dogBreed:DogBreedsModel, imageURL:String) {
        self.init()
        self.dogBreed = dogBreed
        self.imageURL = imageURL
    }
    var name:String {
        return dogBreed?.name ?? Constants.notAvailable
    }
    var breedGroup:String {
        return dogBreed?.breedGroup ?? Constants.notAvailable
    }
    var breedFor:String {
        return dogBreed?.bredFor ?? Constants.notAvailable
    }
    var lifeSpan:String {
        return dogBreed?.lifeSpan ?? Constants.notAvailable
    }
    var origin:String {
        return dogBreed?.origin ?? Constants.notAvailable
    }
}
