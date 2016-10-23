//  BusinessCell.swift
//  Yelp
//
//  Created by Charles Wang on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingsNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    
    var business : Business! {
        didSet {
            businessImage.setImageWith(business.imageURL!)
            businessNameLabel.text = business.name
            ratingImage.setImageWith(business.ratingImageURL!)
            ratingsNumberLabel.text = "\(business.reviewCount!) reviews"
            addressLabel.text = business.address
            tagLabel.text = business.categories
            distanceLabel.text = business.distance
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessImage.layer.cornerRadius = 5
        businessImage.clipsToBounds = true
        
//        businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
