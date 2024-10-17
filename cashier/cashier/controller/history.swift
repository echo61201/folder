//
//  history.swift
//  cashier
//
//  Created by Chelsea on 2024-10-15.
//

import UIKit

class history: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "history"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    var purchaseHistory: [Purchase] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let purchase = purchaseHistory[indexPath.row]
        cell.textLabel?.text = purchase.productName
        cell.detailTextLabel?.text = "\(purchase.quantityPurchased)"
        print("Product Name: \(purchase.productName), Quantity Purchased: \(purchase.quantityPurchased)") // Debugging output
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selecedPurchase = purchaseHistory[indexPath.row]
        let detailController = storyboard?.instantiateViewController(withIdentifier: "details") as! details
        detailController.purchase = selecedPurchase
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    
    

}
