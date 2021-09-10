//
//  LogTableViewCell.swift
//  LightWork
//
//  Created by Test User on 9/9/21.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        innerView.layer.cornerRadius = 17
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
