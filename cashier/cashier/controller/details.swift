//
//  details.swift
//  cashier
//
//  Created by Chelsea on 2024-10-15.
//

import UIKit

class details: UIViewController {

    var purchase : Purchase?
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "purchase details"
        if let purchase = purchase {
            lblType.text = purchase.productName
            lblQuantity.text = "\(purchase.quantityPurchased)"
            lblPrice.text = String(format: "%.2f", purchase.totalPrice) // Format the price to two decimal places
            lblDate.text = DateFormatter.localizedString(from: purchase.purchaseDate, dateStyle: .medium, timeStyle: .none) // Format date
        }
    }
    

    

}
