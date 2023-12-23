//
//  DogBreedListViewModel.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation
import UIKit

class DogBreedListViewModel {
    var limit = 10
    var page = 0
    var selectedIndexPath:IndexPath?
    var dogBreedsArr = [DogBreedsModel]()

    var apiHelper:ServicesProtocol = APIHelper.shared
    
    convenience init(breedsList:DogBreedsArray) {
        self.init()
        self.dogBreedsArr = breedsList
    }
    
    func retriveDogBreedsFromServer(completion: @escaping() -> Void)
    {
        let queryparams = ["limit":limit, "page":page]
        apiHelper.requestEndPoint(endPoint: EndPoint(path: EndPointPath.breads, urlParameters: queryparams)) { [weak self] (result:Result<DogBreedsArray, Error>) in
            switch result {
            case .success(let model):
                self?.dogBreedsArr.append(contentsOf: model)
                completion()
                hideIndicator()
            case .failure(let error):
                print("Error decoding data: \(error)")
                hideIndicator()
                showAlert(withTitle: Constants.appName, andMessage: Constants.noBreedsMessage) {
                    //HANDLE Error For Retry API call
                }
            }
        }
    }
}
