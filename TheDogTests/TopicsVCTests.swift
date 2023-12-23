//
//  DogBreedListVCTests.swift
//  TheDogTests
//
//  Created by Lokesh on 12/21/23.
//

import UIKit
import XCTest
@testable import TheDog

class DogBreedListVCTests: XCTestCase {
    
    var subject:DogBreedListViewController!
    var viewModel = DogBreedListViewModel()
    override func setUp() {
        
        viewModel.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("TheDogBreeds")
        let codableModel = try? JSONDecoder().decode(DogBreedsArray.self, from: jsonData)
        if let model = codableModel {
            viewModel = DogBreedListViewModel(breedsList: model)
            subject = DogBreedListViewController(vm: viewModel)
        }
        subject.viewDidLoad()
        subject.loadView()
        
    }
    
    
    func testViewController(){
        XCTAssertNotNil(subject)
        XCTAssertNotNil(subject.view)
        
    }
    func testSearchControllerMethods(){
        
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(subject.didSelectDogBreed(indexPath: indexPath, imageURL: ""))

        viewModel.selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    func testTopicssViewProperties()
    {
        subject.listView.layoutSubviews()
        XCTAssertNotNil(subject.listView.layoutSubviews())
        XCTAssertNotNil(subject.listView)
        XCTAssertNotNil(subject.listView.viewModel)
        XCTAssertEqual(subject.listView.isServiceCallinProgress, false)
        XCTAssertNotNil(subject.listView.configureView())
        
        
        let numberOfRwos = subject.listView.tableView(subject.listView.tableview, numberOfRowsInSection: 0)
        XCTAssertEqual(subject.viewModel?.dogBreedsArr.count, numberOfRwos)

        let cell:DogBreedListTableViewCell = subject.listView.tableView(subject.listView.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as! DogBreedListTableViewCell
        XCTAssertNotNil(cell)
        let firstItem = viewModel.dogBreedsArr[0]
        cell.configureCell(dogBreed: firstItem)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertEqual(cell.nameLabel.text, firstItem.name)
    }

}
