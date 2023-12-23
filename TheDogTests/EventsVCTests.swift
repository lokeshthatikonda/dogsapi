//
//  EventsVCTests.swift
//  MAADTests
//
//  Created by Balaji Veeranala on 26/05/21.
//

import UIKit
import XCTest
@testable import MAAD

class TopicsViewControllerTests: XCTestCase {
    
    var subject:TopicsViewController!
    var viewModel = TopicsViewModel()
    override func setUp() {
        
        viewModel.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("SimpsonsCharacter")
        let codableModel = try? JSONDecoder().decode(TopicsModel.self, from: jsonData)
        if let model = codableModel {
            viewModel = TopicsViewModel(topicsModel: model)
            subject = TopicsViewController(vm: viewModel)
        }
        subject.viewDidLoad()
        subject.loadView()
        
    }
    
    
    func testViewController(){
        XCTAssertNotNil(subject)
        XCTAssertNotNil(subject.view)
        
    }
    func testSearchControllerMethods(){
        XCTAssertNotNil(subject.searchBarTextDidBeginEditing(UISearchBar()))
        //XCTAssertNotNil(subject.searchBarTextDidEndEditing(UISearchBar()))
        XCTAssertNotNil(subject.searchBarCancelButtonClicked(UISearchBar()))
        XCTAssertNotNil(subject.searchBarSearchButtonClicked(UISearchBar()))
        XCTAssertEqual(subject.textFieldShouldClear(UITextField()), true)
        XCTAssertNotNil(subject.updateTableViewContent())
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(subject.didSelectTopic(indexPath: indexPath))

        viewModel.selectedIndexPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(subject.didSelectFavourite())
    }
    
    func testEventsViewProperties()
    {
        subject.eventsView.layoutSubviews()
        XCTAssertNotNil(subject.eventsView.layoutSubviews())
        XCTAssertNotNil(subject.eventsView)
        XCTAssertNotNil(subject.eventsView.viewModel)
        XCTAssertEqual(subject.eventsView.isServiceCallinProgress, false)
        XCTAssertNotNil(subject.eventsView.configureView())
        
        
        let numberOfRwos = subject.eventsView.tableView(subject.eventsView.tableview, numberOfRowsInSection: 0)
        XCTAssertEqual(subject.viewModel?.getRelatedTopics().count, numberOfRwos)

        let cell:TopicTableViewCell = subject.eventsView.tableView(subject.eventsView.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as! TopicTableViewCell
        XCTAssertNotNil(cell)
        let firstItem = viewModel.getRelatedTopics()[0]
        cell.configureCell(topic: firstItem)
        XCTAssertNotNil(cell.itemTitle)
        XCTAssertEqual(cell.itemTitle.text, firstItem.text)
        XCTAssertNotNil(cell.itemImageView)
    }

}
