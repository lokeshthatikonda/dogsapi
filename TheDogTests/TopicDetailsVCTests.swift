//
//  DogBreedDetailsVCTests.swift
//  TheDogTests
//
//  Created by Lokesh on 12/21/23.
//

import UIKit
import XCTest
@testable import TheDog

class DogBreedDetailsVCTests: XCTestCase {
    
    var subject:DogBreedDetailsVC!
    var viewModel = DogBreedDetailsViewModel()
    override func setUp() {
        let vm = DogBreedListViewModel()
        vm.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("TheDogBreeds")
        let codableModel = try? JSONDecoder().decode(DogBreedsArray.self, from: jsonData)
        if let model = codableModel {
            viewModel = DogBreedDetailsViewModel(dogBreed: model.first!, imageURL: "")
            subject = DogBreedDetailsVC(vm: viewModel)
        }
        subject.viewDidLoad()
        subject.loadView()
        
    }
    
    
    func testViewController(){
        XCTAssertNotNil(viewModel)

        XCTAssertNotNil(subject)
        XCTAssertNotNil(subject.detailsView)
        
//        XCTAssertNotNil(viewModel.topicText)
//        XCTAssertNotNil(viewModel.topicImageURL)
//        XCTAssertNotNil(viewModel.topicResultText)
//        XCTAssertNotNil(viewModel.topicResultText.htmlAttributedString)
    }
}

