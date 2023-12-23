//
//  DogBreedDetailsView.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import UIKit
import SDWebImage

class DogBreedDetailsView: UIView {

    var viewModel = DogBreedDetailsViewModel()
    var tableview = UITableView(frame: .zero, style: .plain)
    var dogImageView:UIImageView = UIImageView()
    
    init(viewModel: DogBreedDetailsViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .white
        self.addSubview(tableview)
        self.addSubview(dogImageView)
        
        dogImageView.contentMode = .scaleAspectFit
        dogImageView.layer.cornerRadius = 6
        dogImageView.layer.masksToBounds = true
        dogImageView.image = UIImage(named: "placeholder")
        dogImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 10, right: self.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 300)

        tableview.anchor(top: dogImageView.bottomAnchor, paddingTop: 10, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 0)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "DogBreedDetailsCellIdentifier")

        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.separatorStyle = .singleLine
        dogImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(named: "placeholder"))

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
    }

}
extension DogBreedDetailsView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailsCell = tableView.dequeueReusableCell(withIdentifier: "DogBreedDetailsCellIdentifier") else {
            return UITableViewCell()
        }
        detailsCell.accessoryType = .none
        var title = ""
        var description = ""
        
        switch indexPath.row {
        case 0:
            title = Constants.name
            description = viewModel.name
        case 1:
            title = Constants.breedGroup
            description = viewModel.breedGroup
        case 2:
            title = Constants.breedFor
            description = viewModel.breedFor
        case 3:
            title = Constants.lifeSpan
            description = viewModel.lifeSpan
        default:
            title = Constants.origin
            description = viewModel.origin
        }
        if #available(iOS 14.0, *) {
            var config = detailsCell.defaultContentConfiguration()
            config.secondaryTextProperties.color = .darkGray
            config.textProperties.color = .black
            config.text = title
            config.secondaryText = description
            detailsCell.contentConfiguration = config
        } else {
            detailsCell.textLabel?.textColor = .black
            detailsCell.detailTextLabel?.textColor = .darkGray
            detailsCell.textLabel?.text = title
            detailsCell.detailTextLabel?.text = description
        }
        return detailsCell

    }
}
