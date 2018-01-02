//
//  ResultControllerTableViewCell.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 2/01/18.
//  Copyright © 2018 Desseyn Pieter. All rights reserved.
//

import UIKit

class ResultControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var caloryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
