//
//  TopicDetailsViewModel.swift
//  TheDog
//
//  Created by Balaji on 21/12/23.
//

import Foundation
import UIKit

class DogBreedDetailsViewModel {
    var dogBreed:DogBreedsModel?

    convenience init(dogBreed:DogBreedsModel) {
        self.init()
        self.dogBreed = dogBreed
    }
    var imageURL:String {
        return dogBreed?.referenceImageID ?? ""
    }
    var name:String {
        return dogBreed?.name ?? ""
    }
    var breedGroup:String {
        return dogBreed?.name ?? ""
    }
    var breedFor:String {
        return dogBreed?.name ?? ""
    }
    var lifeSpan:String {
        return dogBreed?.lifeSpan ?? ""
    }
    var origin:String {
        return dogBreed?.origin ?? ""
    }
}
