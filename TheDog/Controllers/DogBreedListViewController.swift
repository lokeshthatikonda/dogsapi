//
//  DogBreedListViewController.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import UIKit
import MBProgressHUD

class DogBreedListViewController: UIViewController {

    var viewModel:DogBreedListViewModel?
    
    var listView:DogBreedListView {
        return self.view as! DogBreedListView
    }
    
    convenience init(vm: DogBreedListViewModel) {
        self.init()
        self.viewModel = vm
    }
    override func loadView() {
        self.view = DogBreedListView(viewModel: self.viewModel!, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.homePageTitle
        showIndicator()
        viewModel?.retriveDogBreedsFromServer(completion: {
            DispatchQueue.main.async {
                self.listView.tableview.reloadData()
                if self.viewModel?.dogBreedsArr.count == 0 {
                    self.listView.noRecordsLabel.isHidden = false
                    self.listView.tableview.isHidden = true
                } else {
                    self.listView.noRecordsLabel.isHidden = true
                    self.listView.tableview.isHidden = false
                }
            }
        })
    }
}


extension DogBreedListViewController : DogBreedListViewDelegate {
    func didSelectDogBreed(indexPath: IndexPath, imageURL: String) {
        if indexPath.row > viewModel?.dogBreedsArr.count ?? 0 {
            return
        }
        if let dogBreed = viewModel?.dogBreedsArr[indexPath.row] {
            viewModel?.selectedIndexPath = indexPath
            let detailsVC = DogBreedDetailsVC(vm: DogBreedDetailsViewModel(dogBreed: dogBreed, imageURL: imageURL))
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
