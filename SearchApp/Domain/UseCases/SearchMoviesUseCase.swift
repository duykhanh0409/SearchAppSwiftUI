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
    ) -> AnyPublisher<MoviesPage, Error>
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {

    private var moviesSubscription: AnyCancellable?
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    
    func execute(requestValue: SearchMoviesUseCaseRequestValue) -> AnyPublisher<MoviesPage, any Error> {
        moviesRepository
            .fetchMoviesList(query: requestValue.query, page: requestValue.page)
    }

}
