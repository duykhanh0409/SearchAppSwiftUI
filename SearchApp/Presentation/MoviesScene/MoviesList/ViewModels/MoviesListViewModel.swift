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
    var movies: MoviesPage?
    private let searchMoviesUseCase: DefaultSearchMoviesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(searchMoviesUseCase: DefaultSearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
        addSubscripber()
    }
    
    private func addSubscripber() {
        searchMoviesUseCase.$result.sink { (movies: MoviesPage?, error: String?) in
            self.movies = movies
        }
        .store(in: &cancellables)
    }
    
    func fetchMovie() {
        searchMoviesUseCase
            .execute(requestValue: .init(query: .init(query: ""), page: 1))
    }
}
