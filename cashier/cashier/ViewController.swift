//
//  ViewController.swift
//  cashier
//
//  Created by Chelsea on 2024-10-14.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    //=====purchase array
    var purchaseHistory: [Purchase] = []
    
    //======product arrays=============
    
    var products: [Product] = [
        Product(name: "Pants", price: 20.0, quantity: 50,unitPrice: 31.5),
        Product(name: "Shoes", price: 150.0, quantity: 50,unitPrice: 175.5),
        Product(name: "Hats", price: 10.0, quantity: 50,unitPrice: 12),
        Product(name: "T-Shirts", price: 40.0, quantity: 50, unitPrice: 75),
        Product(name: "Dresses", price: 150.0, quantity: 50, unitPrice: 175)
        ]
    //========== variables for selectedproduct and quantity========
    var selectedProduct: Product?
    var purchasedQuantity = 0
    
    //============viewload==============
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "cash register app"
        tableView.dataSource = self;
        tableView.delegate = self;
        lblTotal.text = "\(0)"
    }
    // ============== datasource==================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get the cell and give identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        // get the product object
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.stockLabel?.text = "\(product.quantity)"
        cell.lblUnitprice.text = "\(product.unitPrice)"
        return cell
    }
    //=============delegate====================
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the quantity & total as zero when changing selection
        purchasedQuantity = 0;
        lblQuantity.text = "\(0)"
        lblTotal.text = "\(0)"
        
        
        //get the product and get its attributes
        selectedProduct = products[indexPath.row]
        lblType.text = selectedProduct?.name
        lblQuantity.text = "\(purchasedQuantity)"
        updateTotal()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //parse the number on the buttons
    @IBAction func btnNumber(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text,
              let num = Int(number)
        else {return}
        //no need to get the whole string and then parse
        purchasedQuantity = purchasedQuantity * 10 + num
        lblQuantity.text = "\(purchasedQuantity)"
        updateTotal()
    }
    
    
    //=======buy button==========
    

    @IBAction func btnBuy(_ sender: UIButton) {
        guard let product = selectedProduct else {
            print("no product selected")
            showAlert(_title: "alert", _message: "no product selected")
            return
        }
        
        if purchasedQuantity <= product.quantity {
            let totalPrice = Double(purchasedQuantity) * product.price // Calculate total price here
            let purchase = Purchase(productName: product.name, quantityPurchased: purchasedQuantity, totalPrice: totalPrice, purchaseDate: Date())
            purchaseHistory.append(purchase) // Append purchase to history
            
            product.quantity -= purchasedQuantity // Update product quantity
            purchasedQuantity = 0 // Reset quantity for next purchase
            
            lblQuantity.text = "\(purchasedQuantity)"
            updateTotal()
            selectedProduct = nil
            lblType.text = "Type"
            tableView.reloadData()
        } else {
            print("not enough stock")
            showAlert(_title: "alert", _message: "not enough stock")
        }
        
    }
    
    func updateTotal(){
        guard let product = selectedProduct
        else {
            lblTotal.text = "\(0)"
            print("no product selected")
            showAlert(_title: "alert", _message: "no product selected")
            return
        }
        let total = Double(purchasedQuantity) * product.price
        lblTotal.text = "\(total)"
        
    }
    
    //clear button to clearup quantity
    
    @IBAction func btnClear(_ sender: UIButton) {
        purchasedQuantity = 0
        selectedProduct = nil
        lblType.text = "type"
        lblTotal.text = "\(0)"
        lblQuantity.text = "\(0)"
        //updateTotal()
        
    }
    
    //======alert=========
    func showAlert(_title:String,_message:String) {
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    //adjust cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 
    }
    
    //manager, needs to pass data
    
    @IBAction func btnManager(_ sender: UIButton) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "choice") as! choice
            controller.purchaseHistory = purchaseHistory // Pass the purchase history here
            navigationController?.pushViewController(controller, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Reload the table view to show updated products
    }
    
    
    
}

