//
//  SearchViewModel.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var isLoadingHorizontal: Bool = true

    @Published var fetchedHorizontalMovies: [Movie] = []
    @Published var fetchedVerticalMovies: [Movie] = []

        private let requestManager = RequestManager()

    private(set) var page = 1


        func fetchHorizontalMovies() async {
            isLoadingHorizontal = true
            let requestData = MoviesRequest.getMoviesBy(search: "Comedy", page: page)
            do {
                let movies: SearchStore = try await
                requestManager.perform(requestData)
                fetchedHorizontalMovies += movies.search
            } catch {
                print(error.localizedDescription)
              }
            isLoadingHorizontal = false
        }

    func fetchVerticalMovies(text: String) async {
        let requestData = MoviesRequest.getMoviesBy(search: text, page: 1)
        do {
            let movies: SearchStore = try await
            requestManager.perform(requestData)
            fetchedVerticalMovies = movies.search
        } catch {
            print(error.localizedDescription)
          }
    }

    func fetchMoreMovies() async {
        page += 1
        await fetchHorizontalMovies()
    }

}
