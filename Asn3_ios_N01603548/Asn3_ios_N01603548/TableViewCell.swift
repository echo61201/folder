//
//  TableViewCell.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-05.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblFalse1: UILabel!
    
    @IBOutlet weak var lblFalse2: UILabel!
    
    
    @IBOutlet weak var lblFalse3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
