//
//  HomeCell.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
