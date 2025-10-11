//
//  AppFlowCoordinator.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import SwiftUI

final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func start() -> some View {
        let movieSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        return movieSceneDIContainer.makeMoviesListView()
    }
}
