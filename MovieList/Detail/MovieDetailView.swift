//
//  MovieDetail.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                if let posterURL = URL(string: movie.poster) {
                    AsyncImage(url: posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                        case .failure:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        case .empty:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(movie.year)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    HStack {
                        Text("IMDb ID:")
                            .font(.title3)
                            .fontWeight(.medium)
                        Spacer()
                        Text(movie.imdbID)
                            .font(.title3)
                            .fontWeight(.light)
                    }

                    HStack {
                        Text("Type:")
                            .font(.title3)
                            .fontWeight(.medium)
                        Spacer()
                        Text(movie.type)
                            .font(.title3)
                            .fontWeight(.light)
                    }
                }
                .padding()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}
