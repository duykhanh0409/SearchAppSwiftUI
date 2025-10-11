//
//  MoviesListViewModel.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

@Observable
final class DefaultMovieListViewModel {
    var movies: [Movie] = []
    var errorMessage: String?
    var isLoading: Bool = false
    
    private let searchMoviesUseCase: DefaultSearchMoviesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(searchMoviesUseCase: DefaultSearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
        addSubscripber()
    }
    
    private func addSubscripber() {
        searchMoviesUseCase.$result.sink { [weak self] (moviesPage: MoviesPage?, error: String?) in
            self?.isLoading = false
            if let error = error {
                self?.errorMessage = error
                self?.movies = []
            } else if let moviesPage = moviesPage {
                self?.movies = moviesPage.movies
                self?.errorMessage = nil
            }
        }
        .store(in: &cancellables)
    }
    
    func fetchMovie() {
        isLoading = true
        searchMoviesUseCase
            .execute(requestValue: .init(query: .init(query: "marvel"), page: 1))
    }
}
