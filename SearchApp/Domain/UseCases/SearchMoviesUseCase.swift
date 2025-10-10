//
//  SearchMoviesUseCase.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

struct SearchMoviesUseCaseRequestValue {
    let query: MovieQuery
    let page: Int
}

protocol SearchMoviesUseCase {
    func execute(
        requestValue: SearchMoviesUseCaseRequestValue,
    )
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
  

    @Published var result: (photos: [MoviesPage]?, error: String?) = (nil, nil)
    private var moviesSubscription: AnyCancellable?
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    
    func execute(requestValue: SearchMoviesUseCaseRequestValue) {
        moviesRepository
            .fetchMoviesList(query: requestValue.query, page: requestValue.page)
            .sink{ [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.result = (nil, error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [weak self] dataResponse in
                self?.result = (dataResponse, nil)
                self?.moviesSubscription?.cancel()
            }

    }

}
