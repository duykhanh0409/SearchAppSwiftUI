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
    private let router: MoviesRouter
    private var cancellables = Set<AnyCancellable>()
    
    init(
        searchMoviesUseCase: DefaultSearchMoviesUseCase,
        router: MoviesRouter
    ) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.router = router
        addSubscripber()
    }
    
    private func addSubscripber() {
//        searchMoviesUseCase.$result.sink { [weak self] (moviesPage: MoviesPage?, error: String?) in
//            self?.isLoading = false
//            if let error = error {
//                self?.errorMessage = error
//                self?.movies = []
//            } else if let moviesPage = moviesPage {
//                self?.movies = moviesPage.movies
//                self?.errorMessage = nil
//            }
//        }
//        .store(in: &cancellables)
    }
    
    func fetchMovie() {
        isLoading = true
        searchMoviesUseCase
            .execute(requestValue: .init(query: .init(query: "marvel"), page: 1))
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                    case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    default:
                        break
                    }
            } receiveValue: { [weak self] moviesPage in
                self?.movies = moviesPage.movies
            }
            .store(in: &cancellables)

    }
    
    // MARK: - Navigation Actions
    
    func didSelectMovie(_ movie: Movie) {
        router.navigateToMovieDetails(movie)
    }
}
