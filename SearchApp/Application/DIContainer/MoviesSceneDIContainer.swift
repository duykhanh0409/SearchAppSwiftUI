//
//  MoviesSceneDIContainer.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import Foundation
import SwiftUI

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repositories
    
    func makeMoviesRepository() -> MoviesRepository {
        DefaultMoviesRepository(
            dataTransferService: dependencies.apiDataTransferService
        )
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> DefaultSearchMoviesUseCase {
        DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }
    
    // MARK: - Movies List
    func makeMoviesListViewModel() -> DefaultMovieListViewModel {
        DefaultMovieListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase())
    }
    
    func makeMoviesListView() -> MoviesListView {
        MoviesListView(viewModel: makeMoviesListViewModel())
    }
    
}
