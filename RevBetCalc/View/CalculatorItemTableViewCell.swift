//
//  CalculatorItemTableViewCell.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 6/3/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class CalculatorItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //removes the tablecell background
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        valueLabel.backgroundColor = selected ? UIColor.lightGray : UIColor.white
    }

}
