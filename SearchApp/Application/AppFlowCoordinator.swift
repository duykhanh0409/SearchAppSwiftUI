//
//  AppFlowCoordinator.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import Foundation

final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let movieSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
    }
}
