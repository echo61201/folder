//
//  ProductTableViewCell.swift
//  cashier
//
//  Created by Chelsea on 2024-10-15.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var stockLabel: UILabel!

    @IBOutlet weak var lblUnitprice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
