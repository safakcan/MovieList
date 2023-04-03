//
//  SearchView.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearchButtonChanged: { txt in
                    Task {
                        await viewModel.fetchVerticalMovies(text: txt)
                    }
                })
                .padding(.top)

                List {
                    Section(header: Text("Search Movies")) {
                        ForEach(viewModel.fetchedVerticalMovies) { movie in
                            MovieRow(movie: movie)
                        }
                    }

                    Section(header: Text("Comedy Movies")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(viewModel.fetchedHorizontalMovies.indices, id: \.self) { index in
                                    MovieRow(movie: viewModel.fetchedHorizontalMovies[index])
                                        .onAppear {
                                            if index == viewModel.fetchedHorizontalMovies.count - 1 {
                                                Task {
                                                    await viewModel.fetchMoreMovies()
                                                }
                                            }
                                        }
                                }
                                .padding(.trailing, 16)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .overlay {
                    if viewModel.isLoadingHorizontal {
                        ProgressView("Finding Movies...")
                    }
                }
            }
            .navigationTitle("Movie Search")
            .onAppear {
                Task {
                    await viewModel.fetchHorizontalMovies()
                }
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
