//
//  AppFlowCoordinator.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import SwiftUI

/// Main coordinator for app navigation flow
/// Implements Coordinator pattern for SwiftUI using NavigationPath
final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer
    private let moviesRouter: MoviesRouter
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
        self.moviesRouter = MoviesRouter()
    }
    
    func start() -> some View {
        let movieSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        @Bindable var router = moviesRouter
        
        return NavigationStack(path: $router.navigationPath) {
            movieSceneDIContainer.makeMoviesListView(router: moviesRouter)
                .navigationDestination(for: MoviesRoute.self) { route in
                    self.destination(for: route, with: movieSceneDIContainer)
                }
        }
    }
    
    // MARK: - Private Methods
    
    @ViewBuilder
    private func destination(
        for route: MoviesRoute,
        with container: MoviesSceneDIContainer
    ) -> some View {
        switch route {
        case .movieDetails(let movie):
            container.makeMovieDetailsView(movie: movie)
        }
    }
}
