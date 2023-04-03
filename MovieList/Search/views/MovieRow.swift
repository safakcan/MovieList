//
//  MovieRow.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                if let posterURL = URL(string: movie.poster) {
                    AsyncImage(url: posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .cornerRadius(8)
                        case .failure:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 150)
                        case .empty:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 150)
                        @unknown default:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 150)
                        }
                    }
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 150)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.year)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
            }
        }
    }
}
