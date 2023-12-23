//
//  DogBreedListTableViewCell.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//


import UIKit
import Foundation
import SDWebImage


class DogBreedListTableViewCell: UITableViewCell {

    static var identifer = "DogBreedListTableViewCell"
    var apiHelper:ServicesProtocol = APIHelper.shared
    var nameLabel:UILabel = UILabel()
    var breedLabel:UILabel = UILabel()
    var dogImageView:UIImageView = UIImageView()
    var imageURL = ""
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        
    }
    fileprivate func configureView()  {

        self.selectionStyle = .none
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        breedLabel.font = UIFont.systemFont(ofSize: 12)
        
        contentView.addSubview(dogImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(breedLabel)
        dogImageView.image = UIImage(named: "placeholder")
        dogImageView.anchor(top: contentView.topAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: contentView.leadingAnchor, paddingLeft: 5, right: nil, paddingRight: 0, centerX: nil, centerY: nil, width: 60, height: 60)
        dogImageView.layer.cornerRadius = 6
        dogImageView.layer.masksToBounds = true
        dogImageView.contentMode = .scaleAspectFit
        
        nameLabel.anchor(top: contentView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: dogImageView.trailingAnchor, paddingLeft: 5, right: contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 20)
        nameLabel.textColor = .black
        breedLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: nameLabel.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 20)
        breedLabel.textColor = .darkGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(dogBreed:DogBreedsModel) {
        nameLabel.text = dogBreed.name ?? Constants.nameNotAvailable
        breedLabel.text = dogBreed.bredFor ?? Constants.breedNotAvailable
        if imageURL != "" {
            return
        }
        guard let imageID = dogBreed.referenceImageID else { return }
        let imageURLPath = EndPointPath.images + "/" + imageID
        apiHelper.requestEndPoint(endPoint: EndPoint(path: imageURLPath)) { [weak self] (result:Result<BreedImageModel, Error>) in
            switch result {
            case .success(let model):
                if let url = model.url {
                    self?.imageURL = url
                    self?.dogImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
                }
            case .failure(let error):
                print("Error decoding data: \(error)")
                //IGNORE Error Here since its a Sailent CAll
            }
        }
    }
}
