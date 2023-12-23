//
//  DogBreedViewModelTests.swift
//  TheDogTests
//
//  Created by Lokesh on 12/21/23.
//

import XCTest
@testable import TheDog

class DogBreedViewModelTests: XCTestCase {
    
    var viewModel = DogBreedListViewModel()
    
    override func setUp() {
        super.setUp()
        viewModel.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("TheDogBreeds")
        let codableModel = try? JSONDecoder().decode(DogBreedsArray.self, from: jsonData)
        if let model = codableModel {
            viewModel = DogBreedListViewModel(breedsList: model)
        }
    }
    func testViewModelFunctions() {
        XCTAssertNotNil(viewModel)
        XCTAssertGreaterThan((viewModel.dogBreedsArr.count), 0)
        
    }
    func testAPIMethods() {
        viewModel.retriveDogBreedsFromServer {
            XCTAssertGreaterThan((self.viewModel.dogBreedsArr.count), 0)
        }
    }

}
