//
//  TableViewCell.swift
//  blabby
//
//  Created by Indu Yadav on 15/03/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var notificationTableViewCellLabel: UILabel!
    @IBOutlet var notificationTableViewCellButton: UIButton!

}
