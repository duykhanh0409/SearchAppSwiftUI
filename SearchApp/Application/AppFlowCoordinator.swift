//
//  AppFlowCoordinator.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import SwiftUI

/// Main coordinator for app navigation flow
/// Implements Coordinator pattern for SwiftUI using NavigationPath
@Observable
final class AppFlowCoordinator {
    
    // MARK: - Properties
    
    private let appDIContainer: AppDIContainer
    private let moviesRouter: MoviesRouter
    
    /// Tracks whether splash screen has been dismissed
    var showSplashScreen: Bool = true
    
    // MARK: - Initialization
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
        self.moviesRouter = MoviesRouter()
    }
    
    // MARK: - Public Methods
    
    func start() -> some View {
        AppRootView(coordinator: self)
    }
    
    /// Navigate from splash screen to movies screen
    func navigateToMovies() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showSplashScreen = false
        }
    }
    
    // MARK: - View Builders
    
    /// Build the movies scene with navigation
    @ViewBuilder
    func makeMoviesScene() -> some View {
        let movieSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        @Bindable var router = moviesRouter
        
        NavigationStack(path: $router.navigationPath) {
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

// MARK: - App Root View

/// Root view that handles splash screen to movies screen transition
private struct AppRootView: View {
    @Bindable var coordinator: AppFlowCoordinator
    
    var body: some View {
        ZStack {
            if coordinator.showSplashScreen {
                // Show UIKit Splash Screen
                SplashScreenView {
                    coordinator.navigateToMovies()
                }
                .transition(.opacity)
                .zIndex(1)
            } else {
                // Show SwiftUI Movies Screen
                coordinator.makeMoviesScene()
                    .transition(.opacity)
                    .zIndex(0)
            }
        }
    }
}
