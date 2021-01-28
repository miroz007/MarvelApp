//
//  CoverCell.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit

class CoverCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
