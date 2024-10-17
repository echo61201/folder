//
//  Product.swift
//  cashier
//
//  Created by Chelsea on 2024-10-14.
//

import Foundation
class Product {
    var name: String
    var price: Double
    var quantity: Int
    var unitPrice : Double
    
    init(name: String, price: Double, quantity: Int, unitPrice: Double) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
}
