//
//  EventDetailsVCTests.swift
//  MAADTests
//
//  Created by Balaji Veeranala on 26/05/21.
//

import UIKit
import XCTest
@testable import MAAD

class TopicDetailsVCTests: XCTestCase {
    
    var subject:TopicDetailsVC!
    var viewModel = TopicDetailsViewModel()
    override func setUp() {
        let vm = TopicsViewModel()
        vm.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("SimpsonsCharacter")
        let codableModel = try? JSONDecoder().decode(TopicsModel.self, from: jsonData)
        if let model = codableModel {
            if let topics =  model.relatedTopics {
                viewModel = TopicDetailsViewModel(topic: topics.first!)
                subject = TopicDetailsVC(vm: viewModel, delegate: self)
            }
        }
        subject.viewDidLoad()
        subject.loadView()
        
    }
    
    
    func testViewController(){
        XCTAssertNotNil(viewModel)

        XCTAssertNotNil(subject)
        XCTAssertNotNil(subject.detailsView)
        
        XCTAssertNotNil(viewModel.topicText)
        XCTAssertNotNil(viewModel.eventImage)
        XCTAssertNotNil(viewModel.eventdateTime.formatedDateTime)
        XCTAssertNotNil(viewModel.eventDisplayAddress)
    }
}
extension TopicDetailsVCTests: TopicDetailsVCDelegate {
    func didSelectFavourite() {
        
    }
}
    
