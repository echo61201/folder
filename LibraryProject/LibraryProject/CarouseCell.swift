//
//  CarouseCell.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-06.
//

import UIKit

class CarouseCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            bookImageView.contentMode = .scaleAspectFit // Ensure the cover image fits nicely
            bookImageView.layer.cornerRadius = 8        // Add rounded corners
            bookImageView.clipsToBounds = true
        }
    
}
