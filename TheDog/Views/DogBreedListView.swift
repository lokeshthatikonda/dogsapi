//
//  DogBreedListView.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation
import UIKit

protocol DogBreedListViewDelegate {
    func didSelectDogBreed(indexPath:IndexPath, imageURL: String)
}


class DogBreedListView: UIView {

    var viewModel:DogBreedListViewModel?
    var noRecordsLabel:UILabel = UILabel()
    var tableview = UITableView(frame: .zero, style: .plain)
    var isServiceCallinProgress = false
    var delegate:DogBreedListViewDelegate?

    init(viewModel: DogBreedListViewModel, delegate:DogBreedListViewDelegate) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.delegate = delegate
        configureView()
    }
    
    func configureView() {
        self.addSubview(tableview)
        self.addSubview(noRecordsLabel)
        
        self.backgroundColor = .white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(DogBreedListTableViewCell.self, forCellReuseIdentifier: DogBreedListTableViewCell.identifer)
        tableview.tableFooterView = UIView()
        tableview.anchor(top: self.topAnchor, paddingTop: 0, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 0)
        
        noRecordsLabel.numberOfLines = 0
        noRecordsLabel.lineBreakMode = .byWordWrapping
        noRecordsLabel.textColor = .darkGray
        noRecordsLabel.font = UIFont(name: "Helvetica", size: 14)
        noRecordsLabel.textAlignment = .center
        noRecordsLabel.text = Constants.noBreedsMessage
        noRecordsLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 10, right: self.trailingAnchor, paddingRight: 10, centerX: self.centerXAnchor, centerY: self.centerYAnchor, width: 0, height: 0)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DogBreedListView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.dogBreedsArr.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: DogBreedListTableViewCell.identifer) as? DogBreedListTableViewCell
        itemCell?.accessoryType = .disclosureIndicator
        itemCell?.configureCell(dogBreed: (viewModel?.dogBreedsArr[indexPath.row])!)
        return itemCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? DogBreedListTableViewCell
        self.delegate?.didSelectDogBreed(indexPath: indexPath, imageURL: selectedCell?.imageURL ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension DogBreedListView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if isServiceCallinProgress == false {
                showIndicator()
                viewModel?.limit += 10
                viewModel?.page += 1
                isServiceCallinProgress = !isServiceCallinProgress
                print(" you reached end of the table")
                viewModel?.retriveDogBreedsFromServer(completion: {
                    self.isServiceCallinProgress = !self.isServiceCallinProgress
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                        hideIndicator()
                    }
                })
            }
            
        }
    }
}
