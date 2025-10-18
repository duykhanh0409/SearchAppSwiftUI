//
//  DefaultMoviesRepository.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

final class DefaultMoviesRepository {
    private let dataTransferService: DataTransferService
    
    init(
        dataTransferService: DataTransferService
    ) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultMoviesRepository: MoviesRepository {
    
    func fetchMoviesList(query: MovieQuery, page: Int) -> AnyPublisher<MoviesPage, any Error> {
        
        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
        let endpoint = APIEndpoints.getMovies(with: requestDTO)
        
        return dataTransferService.request(with: endpoint)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}

