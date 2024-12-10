//
//  BookDetailsViewController.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-06.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    var book: Book?


    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let book = book else { return }

            titleLabel.text = book.title
            descriptionLabel.text = book.description ?? "No description available."
            coverImageView.loadImage(from: book.coverURL ?? "")

        
    }
    
    
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        guard let book = book else { return }

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let savedBook = SavedBook(context: context)
            savedBook.title = book.title
            savedBook.author = book.authors?.joined(separator: ", ") ?? "Unknown Author"
            savedBook.timestamp = Date()

            do {
                try context.save()
                let alert = UIAlertController(title: "Success", message: "Book added to local library!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } catch {
                print("Failed to save book: \(error)")
            }
        
    }
    
    

}
