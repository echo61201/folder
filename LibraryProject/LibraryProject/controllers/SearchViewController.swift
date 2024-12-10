//
//  SearchViewController.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-07.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    

    func searchBooks(query: String) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Raw JSON response: \(json)")
                let items = json?["items"] as? [[String: Any]]

                self.searchResults = items?.compactMap { item in
                    if let volumeInfoData = try? JSONSerialization.data(withJSONObject: item["volumeInfo"] ?? [:], options: []),
                       let book = try? JSONDecoder().decode(Book.self, from: volumeInfoData) {
                        return book
                    }
                    return nil
                } ?? []

                print("Search results: \(self.searchResults)")

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }


    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchBooks(query: query)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let book = searchResults[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.authors?.joined(separator: ", ") ?? "Unknown Author"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = searchResults[indexPath.row]
        performSegue(withIdentifier: "showBookDetailsFromSearch", sender: selectedBook)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetailsFromSearch",
           let detailsVC = segue.destination as? BookDetailsViewController,
           let selectedBook = sender as? Book {
            detailsVC.book = selectedBook
        }
    }




    

}
