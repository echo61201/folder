//
//  LibraryController.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-07.
//

import UIKit
import CoreData

class LibraryController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var savedBooks: [SavedBook] = []
    


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchSavedBooks()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return savedBooks.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) ??
                       UITableViewCell(style: .subtitle, reuseIdentifier: "LibraryCell")
            let book = savedBooks[indexPath.row]
            cell.textLabel?.text = book.title
            cell.detailTextLabel?.text = book.author
            return cell
    }
    
    func fetchSavedBooks() {
        //we gonna use CoreData here
        // functions similar to sqlite in android to me, but syntax way more complicated
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
        // we did a timestamp for better sorting
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            savedBooks = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Failed to fetch saved books: \(error)")
        }
    }
    // this one is actually new to me, delete by scrolling, from gpt
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(savedBooks[indexPath.row])
            savedBooks.remove(at: indexPath.row)

            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Failed to delete book: \(error)")
            }
        }
    }


    

    

}
