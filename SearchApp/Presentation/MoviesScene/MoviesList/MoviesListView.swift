//
//  MoviesListView.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import SwiftUI

struct MoviesListView: View {
    @State private var viewModel: DefaultMovieListViewModel
    
    init(viewModel: DefaultMovieListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text("Error")
                            .font(.headline)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.fetchMovie()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if viewModel.movies.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No movies found")
                            .font(.headline)
                    }
                } else {
                    List(viewModel.movies) { movie in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title ?? "Unknown")
                                .font(.headline)
                            
                            if let overview = movie.overview {
                                Text(overview)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Movies")
            .onAppear {
                if viewModel.movies.isEmpty && !viewModel.isLoading {
                    viewModel.fetchMovie()
                }
            }
        }
    }
}

