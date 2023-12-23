//
//  EventsViewModel.swift
//  MAAD
//
//  Created by Balaji Veeranala on 15/05/21.
//

import Foundation
import UIKit

class TopicsViewModel {
    
    var selectedIndexPath:IndexPath?
    var topicsModel:TopicsModel?
    var filterdTopicsModel:TopicsModel?
    var apiHelper:ServicesProtocol = APIHelperMock.shared
    var topicsArr:[RelatedTopic] {
        return topicsModel?.relatedTopics ?? [RelatedTopic]()
    }
    var filterTopics:[RelatedTopic] {
        return filterdTopicsModel?.relatedTopics ?? [RelatedTopic]()
    }
    var isSearchEnabled:Bool = false
    
    func getEvents() -> [RelatedTopic] {
        if isSearchEnabled {
            if filterdTopicsModel == nil {
                return [RelatedTopic]()
            }
            return filterTopics
        }
        if topicsModel == nil {
            return [RelatedTopic]()
        }
        return topicsArr
    }
    
    convenience init(topicsModel:TopicsModel) {
        self.init()
        self.topicsModel = topicsModel
        //setEventsModel(newValue: eventsModel)
    }
    /*func setEventsModel(newValue:EventsModel) {
        self.eventsModel = newValue
    }
    func appendEventsToArray(events:[Event]) {
        evetnsArr.append(contentsOf: events)
    }
    
    var afterIndex:String {
        /*if let after = eventsModel.data?.after, after.count > 0 {
            return after
        }*/
        return ""
    }*/
    /*func updateEventsFavouriteStatus(events:[Event]) {
        let results =  getAllEventsFromDB()
        for dbEvent in results {
            var obj = events.filter{ $0.id ?? 0 == dbEvent.id }
            if obj.count > 0 {
                obj.first?.isFavourite = true
            }
        }
    }
    ! {
        didSet {
            updateEventsFavouriteStatus(events: eventsModel.events ?? [Event]())
        }
    }*/
    func retriveEventsFromServer(searchTerm:String? = "", completion: @escaping() -> Void)
    {
        let endPoint = searchTerm?.count == 0 ? EndPoint() : EndPoint(urlParameters: ["q":searchTerm!])
        
        apiHelper.retrieveTopics(endPoint: endPoint) { (model, erroe) in
            if let topicsModel = model {
                if self.isSearchEnabled {
                    self.filterdTopicsModel = topicsModel
                }else{
                    self.topicsModel = topicsModel
                }
                completion()
            }
            DispatchQueue.main.async {
                hideIndicator()
            }
        }
    }

    
}
