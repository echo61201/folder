//
//  choice.swift
//  cashier
//
//  Created by Chelsea on 2024-10-15.
//

import UIKit

class choice: UIViewController {
    var purchaseHistory: [Purchase] = []
    //var products:[Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(purchaseHistory)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnHistory(_ sender: UIButton) {
        let historyController = storyboard!.instantiateViewController(withIdentifier: "history") as! history
        historyController.purchaseHistory = purchaseHistory
        navigationController?.pushViewController(historyController, animated: true)
        
    }
    
    
    @IBAction func btnRestock(_ sender: UIButton) {
        let restockController = storyboard!.instantiateViewController(withIdentifier: "stock") as! Stock
        
        navigationController?.pushViewController(restockController, animated: true)
    }
    

}
