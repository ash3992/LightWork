//
//  ZipTableViewCell.swift
//  LightWork
//
//  Created by Test User on 8/27/21.
//

import UIKit

class ZipTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityAndStateLabel: UILabel!
    @IBOutlet weak var poulationLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
