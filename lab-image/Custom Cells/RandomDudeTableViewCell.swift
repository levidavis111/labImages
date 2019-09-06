//
//  RandomDudeTableViewCell.swift
//  lab-image
//
//  Created by Levi Davis on 9/6/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class RandomDudeTableViewCell: UITableViewCell {
    @IBOutlet weak var randomDudeCellImage: UIImageView!
    @IBOutlet weak var randomDudeCellNameLabel: UILabel!
    @IBOutlet weak var randomDudeCellAgeLabel: UILabel!
    @IBOutlet weak var randomDudeCellMobilePhoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
