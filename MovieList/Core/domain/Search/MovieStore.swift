//
//  MovieStore.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import Foundation

struct SearchStore: Codable {
    var search: [Movie] = []

    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
    init() {
#if DEBUG
        createData()
#endif
    }
}

struct Movie: Codable, Identifiable {
    var id = UUID()
    var title  : String
    var year   : String
    var imdbID : String
    var type   : String
    var poster : String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID = "imdbID"
        case type = "Type"
    }
}

extension SearchStore {

    mutating func createData() {
        search = [
            Movie(title: "Batman", year: "121", imdbID: "123123", type: "action", poster: "url"),
            Movie(title: "Superman", year: "121", imdbID: "123123", type: "action", poster: "url")
        ]
    }
}
