//
//  Purchases.swift
//  cashier
//
//  Created by Chelsea on 2024-10-15.
//

import Foundation


class Purchase {
    let productName: String
    let quantityPurchased: Int
    let totalPrice: Double
    let purchaseDate: Date

    init(productName: String, quantityPurchased: Int, totalPrice: Double, purchaseDate: Date) {
        self.productName = productName
        self.quantityPurchased = quantityPurchased
        self.totalPrice = totalPrice
        self.purchaseDate = purchaseDate
    }
}
