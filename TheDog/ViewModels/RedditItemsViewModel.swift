//
//  RedditItemsViewModel.swift
//  Reddit
//
//  Created by Balaji Veeranala on 26/04/21.
//

import Foundation

class EventsViewModel {
    
    var apiHelper:ServicesProtocol = APIHelperMock.shared
    var childrenArr:[Child] = [Child]()
    var redditModel:RedditModel!{
        didSet {
            if let children = redditModel.data?.children {
                appendChildrensToArray(children: children)
            }
        }
    }
    
    convenience init(redditModel:RedditModel) {
        self.init()
        
        setRedditModel(newValue: redditModel)
    }
    func setRedditModel(newValue:RedditModel) {
        self.redditModel = newValue
    }
    func appendChildrensToArray(children:[Child]) {
        childrenArr.append(contentsOf: children)
    }
    
    var afterIndex:String {
        if let after = redditModel.data?.after, after.count > 0 {
            return after
        }
        return ""
    }
    
    func retriveItemsFromServer(after:String? = "", completion: @escaping() -> Void)
    {
        let endPoint = after?.count == 0 ? EndPoint() : EndPoint(urlParameters: ["after":after!])
        
        apiHelper.retrieveItems(endPoint: endPoint) { (model, erroe) in
            if let redditModel = model {
                self.redditModel = redditModel
                completion()
                DispatchQueue.main.async {
                    hideIndicator()
                }
            }
        }
    }
}
