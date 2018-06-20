//
//  AlarmTableViewCell.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 19/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
//MARK: Protocol initialisation to pass switch state
protocol switchState{
    func buttonToggled(sender:AlarmTableViewCell,state: Bool)
}

class AlarmTableViewCell: UITableViewCell {
    var stateDelegate : switchState?
    
    @IBOutlet weak var switchKey: UISwitch!
    
    @IBAction func toggleSwitch(_ sender: UISwitch){
        stateDelegate?.buttonToggled(sender:self, state: switchKey.isOn)
        
    }
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
