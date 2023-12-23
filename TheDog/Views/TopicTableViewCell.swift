//
//  TopicTableViewCell.swift
//  TheDog
//
//  Created by Balaji on 21/12/23.
//


import UIKit
//import SDWebImage

class DogBreedListTableViewCell: UITableViewCell {

    static var identifer = "TopicsTableViewCell"
    
    var topicTextLabel:UILabel = UILabel()
    var itemImageView:UIImageView = UIImageView()
    
    var resultLabel:UILabel = UILabel()
    
    var bgView:UIView = UIView()
    var shadowLayer = ShadowView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        
    }
    fileprivate func configureView()  {

        self.contentView.insertSubview(shadowLayer, at: 0)
        self.contentView.insertSubview(bgView, at: 1)
        self.selectionStyle = .none
        topicTextLabel.numberOfLines = 0
        topicTextLabel.font = UIFont.boldSystemFont(ofSize: 14)
        resultLabel.font = UIFont.systemFont(ofSize: 12)
        
        
        bgView.addSubview(itemImageView)
        bgView.addSubview(topicTextLabel)
        bgView.addSubview(resultLabel)
        bgView.layer.cornerRadius = 6
        bgView.layer.masksToBounds = true
        

        bgView.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: self.contentView.leadingAnchor, paddingLeft: 10, right: self.contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        bgView.backgroundColor = .white
        
        shadowLayer.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: self.contentView.leadingAnchor, paddingLeft: 10, right: self.contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)


        itemImageView.anchor(top: bgView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: bgView.leadingAnchor, paddingLeft: 10, right: nil, paddingRight: 0, centerX: nil, centerY: nil, width: 44, height: 44)
        itemImageView.layer.cornerRadius = 6
        itemImageView.layer.masksToBounds = true


        topicTextLabel.anchor(top: bgView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemImageView.trailingAnchor, paddingLeft: 10, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        topicTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        
        resultLabel.anchor(top: topicTextLabel.bottomAnchor, paddingTop: 0, bottom: bgView.bottomAnchor, paddingBottom: 10, left: topicTextLabel.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 18)
        
        //anchor(top: resultLabel.bottomAnchor, paddingTop: 0, bottom: bgView.bottomAnchor, paddingBottom: 10, left: topicTextLabel.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
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
        topicTextLabel.text = dogBreed.name
        resultLabel.text = dogBreed.name
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
}


class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
