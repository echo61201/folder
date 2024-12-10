//
//  Book.swift
//  LibraryProject
//
//  Created by Chelsea on 2024-12-06.
//

struct Book: Decodable {
    let title: String
    let authors: [String]?
    let description: String?
    let coverURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case description
        case imageLinks
    }

    enum ImageLinksKeys: String, CodingKey {
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "No Title"
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)

        if let imageLinks = try? container.nestedContainer(keyedBy: ImageLinksKeys.self, forKey: .imageLinks),
           let httpCoverURL = try? imageLinks.decode(String.self, forKey: .thumbnail) {
            // Replace http with https
            self.coverURL = httpCoverURL.replacingOccurrences(of: "http://", with: "https://")
        } else {
            self.coverURL = nil
        }
    }
}


