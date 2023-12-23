//
//  DogBreedDetailsVC.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import UIKit


class DogBreedDetailsVC: UIViewController {

    var viewModel:DogBreedDetailsViewModel?
    var detailsView:DogBreedDetailsView {
        return self.view as! DogBreedDetailsView
    }
    convenience init(vm: DogBreedDetailsViewModel) {
        self.init()
        self.viewModel = vm
    }
    
    override func loadView() {
        self.view = DogBreedDetailsView(viewModel: self.viewModel!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.detailsPageTitle

    }

}
