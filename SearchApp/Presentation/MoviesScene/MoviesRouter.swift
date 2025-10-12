//
//  MoviesRouter.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 12/10/25.
//

import SwiftUI

/// Defines all possible routes in Movies Scene
enum MoviesRoute: Hashable {
    case movieDetails(Movie)
}

/// Router for handling navigation in Movies Scene
/// Follows Coordinator pattern adapted for SwiftUI
@Observable
final class MoviesRouter {
    var navigationPath = NavigationPath()
    
    // MARK: - Navigation Actions
    
    func navigateToMovieDetails(_ movie: Movie) {
        navigationPath.append(MoviesRoute.movieDetails(movie))
    }
    
    func navigateBack() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}

