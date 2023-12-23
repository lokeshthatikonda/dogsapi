//
//  ItemsTableViewCell.swift
//  Reddit
//
//  Created by Balaji Veeranala on 26/04/21.
//

import UIKit
import SDWebImage

class EventsTableViewCell: UITableViewCell {

    static var identifer = "ItemsTableViewCell"
    
    var itemTitle:UILabel = UILabel()
    var itemImageView:UIImageView = UIImageView()
    
    var cityLabel:UILabel = UILabel()
    var dateTimeLabel:UILabel = UILabel()
    
    var bgView:UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        
    }
    fileprivate func configureView()  {
        
        self.contentView.insertSubview(bgView, at: 0)
        
        itemTitle.numberOfLines = 0
        itemTitle.font = UIFont.boldSystemFont(ofSize: 14)
        cityLabel.font = UIFont.systemFont(ofSize: 12)
        dateTimeLabel.font = UIFont.systemFont(ofSize: 12)
        
        
        bgView.addSubview(itemImageView)
        bgView.addSubview(itemTitle)
        bgView.addSubview(cityLabel)
        bgView.addSubview(dateTimeLabel)

        bgView.anchor(top: self.contentView.topAnchor, paddingTop: 10, bottom: self.contentView.bottomAnchor, paddingBottom: 10, left: self.contentView.leadingAnchor, paddingLeft: 10, right: self.contentView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        bgView.backgroundColor = .red
        bgView.layer.cornerRadius = 6
        bgView.layer.masksToBounds = true


        itemImageView.anchor(top: bgView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: bgView.leadingAnchor, paddingLeft: 10, right: nil, paddingRight: 0, centerX: nil, centerY: nil, width: 44, height: 44)
        //itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 1.0/2.0).isActive = true
        itemImageView.layer.cornerRadius = 6
        itemImageView.layer.masksToBounds = true

        itemTitle.anchor(top: bgView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: itemImageView.trailingAnchor, paddingLeft: 10, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        itemTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        
        
        cityLabel.anchor(top: itemTitle.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: itemTitle.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 18)
        
        dateTimeLabel.anchor(top: cityLabel.bottomAnchor, paddingTop: 0, bottom: bgView.bottomAnchor, paddingBottom: 0, left: itemTitle.leadingAnchor, paddingLeft: 0, right: bgView.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(child:Child) {
        itemTitle.text = child.data?.title
        itemImageView.sd_setImage(with: URL(string: child.data?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cityLabel.text = "cityLabel"
        dateTimeLabel.text = "dateTimeLabel"

        /*if child.data?.thumbnailWidth ?? 0 > child.data?.thumbnailHeight ?? 0 {
            itemImageView.contentMode = .scaleAspectFit
        } else {
            itemImageView.contentMode = .scaleAspectFill
        }*/
        
    }
}
