//
//  AllPersoneTableViewCell.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import UIKit

class AllPersoneTableViewCell: UITableViewCell {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var namePersonLabel: UILabel!
    @IBOutlet weak var statusPersonLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var last_locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
