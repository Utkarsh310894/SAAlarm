//
//  clockTableViewCell.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 20/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class clockTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgClockView: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
