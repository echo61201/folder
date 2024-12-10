//
//  ViewController.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-06.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of books in collection view: \(popularBooks.count)")
        return popularBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //populating items
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouseCell
        let book = popularBooks[indexPath.item]

        // Debugging: Print the book title and cover URL
        print("Image URL for book \(book.title): \(book.coverURL ?? "No URL")")

        // Attempt to load the book's cover image
        cell.bookImageView.loadImage(from: book.coverURL ?? "")

        return cell
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //so the book cover won't take the full collectionView
            return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    
    // initialization of components

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    var popularBooks: [Book] = [] // Array for popular books
    var autoScrollTimer: Timer?
    
    func startAutoScroll() {
        // do a timer fire every 3 seconds
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            //access the collection view
            guard let collectionView = self.carouselCollectionView else { return }
            //stores the currently visible item
            let visibleIndexPath = collectionView.indexPathsForVisibleItems.first
            // if nil, gonna pass -1, if not nil, then current index add 1
            let nextItem = (visibleIndexPath?.item ?? -1) + 1
            //ensures that the next index "wraps around" when it reaches the end of the collection.
            let nextIndexPath = IndexPath(item: nextItem % self.popularBooks.count, section: 0)
            //tells the collection view to scroll to the item at the specified IndexPath
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAutoScroll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        //==========
        fetchPopularBooks()
        //==========
        // Do any additional setup after loading the view.
    }
    
    func fetchPopularBooks() {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=popular"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("No data received from server")
                return
            }

            do {
                //decode the json using bookapiresponse struct
                // it's like a schema, we use that to get the received data in an expected way
                let apiResponse = try JSONDecoder().decode(BookAPIResponse.self, from: data)
                self.popularBooks = apiResponse.items.compactMap { $0.volumeInfo }
                print("Successfully decoded \(self.popularBooks.count) books.")
                DispatchQueue.main.async {
                    //make sure all data is loaded then we load them into the collectionView
                    self.carouselCollectionView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }




    // API Response Mapping
    // Book is already structed
    struct BookAPIResponse: Decodable {
        let items: [Volume]

        struct Volume: Decodable {
            let volumeInfo: Book
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // be sure to identify that segue in attributes inspector
        if segue.identifier == "showBookDetails" {
            if let detailsVC = segue.destination as? BookDetailsViewController,
               //click on the cell would direct to corresponding book so we gonna get its index first
               let cell = sender as? UICollectionViewCell,
               let indexPath = carouselCollectionView.indexPath(for: cell) {
                // Pass the selected book to the details view controller
                let selectedBook = popularBooks[indexPath.item]
                detailsVC.book = selectedBook
            }
        }
    }


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //the automatic segue deals with this, no need to do it manually
    }
    
    

    @IBAction func btnLocalLibrary(_ sender: UIButton) {
        let libraryVC = storyboard?.instantiateViewController(withIdentifier: "LibraryController") as! LibraryController
            navigationController?.pushViewController(libraryVC, animated: true)
    }
    
    

    @IBAction func openSearch(_ sender: UIButton) {
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
}

