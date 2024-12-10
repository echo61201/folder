//
//  UIImageView+Extensions.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-06.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        // Set placeholder image initially
        self.image = placeholder ?? UIImage(named: "placeholder") // Use your placeholder image name

        // Check if the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL for image: \(urlString)")
            return
        }

        // Fetch the image asynchronously
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to load image from URL: \(urlString)")
                return
            }

            // Update the image on the main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}




