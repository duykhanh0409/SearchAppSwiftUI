//
//  MovieDetailsView.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 12/10/25.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Movie Poster Placeholder
                if let posterPath = movie.posterPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 400)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .frame(height: 400)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .frame(height: 400)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 400)
                        .overlay(
                            Image(systemName: "film")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                        )
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(movie.title ?? "Unknown Title")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Release Date
                    if let releaseDate = movie.releaseDate {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.secondary)
                            Text("Release Date:")
                                .foregroundColor(.secondary)
                            Text(releaseDate, style: .date)
                                .fontWeight(.medium)
                        }
                        .font(.subheadline)
                    }
                    
                    // Genre
                    if let genre = movie.genre {
                        HStack {
                            Image(systemName: "theatermasks")
                                .foregroundColor(.secondary)
                            Text("Genre:")
                                .foregroundColor(.secondary)
                            Text(genreText(genre))
                                .fontWeight(.medium)
                        }
                        .font(.subheadline)
                    }
                    
                    Divider()
                    
                    // Overview
                    if let overview = movie.overview, !overview.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Overview")
                                .font(.headline)
                            Text(overview)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func genreText(_ genre: Movie.Genre) -> String {
        switch genre {
        case .adventure:
            return "Adventure"
        case .scienceFiction:
            return "Science Fiction"
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailsView(
            movie: Movie(
                id: "1",
                title: "The Avengers",
                genre: .scienceFiction,
                posterPath: "/path/to/poster.jpg",
                overview: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.",
                releaseDate: Date()
            )
        )
    }
}

