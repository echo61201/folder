//
//  Stock.swift
//  cashier
//
//  Created by Chelsea on 2024-10-16.
//

import UIKit

class Stock: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var btnRestock: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtQuantity: UITextField!
    
    var products:[Product] = []
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "restock"
        tableView.dataSource = self
        tableView.delegate = self
        //===================
        loadProducts()
        //===================
    }
    
    func loadProducts(){
        if let mainVC = navigationController?.viewControllers.first as? ViewController {
            products = mainVC.products
        }
        tableView.reloadData()
    }

    @IBAction func btnRestock(_ sender: UIButton) {
        guard let quantitytxt = txtQuantity.text,
              let quantity = Int(quantitytxt),quantity > 0,
              let selectedProduct = selectedProduct else {
            showAlert("error", "select a product and enter valid quantity")
            return

        }
        selectedProduct.quantity += quantity
        txtQuantity.text = ""
        loadProducts()
        
        if let mainVC = navigationController?.viewControllers.first as? ViewController {
            mainVC.products = products
        }
        
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        txtQuantity.text = ""
        selectedProduct = nil
        btnRestock.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productcell",for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.quantity)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedProduct != nil {
            btnRestock.isEnabled = true
        }else {
            btnRestock.isEnabled = false
        }
    }
    
    func showAlert(_ title:String, _ message: String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    
    
}
