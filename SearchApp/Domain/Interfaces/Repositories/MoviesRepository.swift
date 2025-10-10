//
//  MoviesRepository.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

protocol Cancellable {
    func cancel()
}

protocol MoviesRepository {
    
    func fetchMoviesList(
        query: MovieQuery,
        page: Int,
    ) -> AnyPublisher<[MoviesPage], Error>
}
