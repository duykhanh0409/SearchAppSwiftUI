//
//  SplashScreenView.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 30/10/25.
//

import SwiftUI

/// SwiftUI wrapper for UIKit SplashScreenController
struct SplashScreenView: UIViewControllerRepresentable {
    
    /// Callback when user wants to navigate to movies
    var onNavigateToMovies: () -> Void
    
    func makeUIViewController(context: Context) -> SplashScreenController {
        let controller = SplashScreenController()
        controller.onNavigateToMovies = onNavigateToMovies
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SplashScreenController, context: Context) {
        // Update nếu cần trong tương lai
    }
}

// MARK: - Preview

#Preview {
    SplashScreenView {
        print("Navigate to movies")
    }
}

