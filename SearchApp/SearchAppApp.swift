//
//  SearchAppApp.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 6/10/25.
//

import SwiftUI

@main
struct SearchAppApp: App {
    // Initialize DI Container (equivalent to AppDelegate setup)
    private let appDIContainer = AppDIContainer()
    private let appFlowCoordinator: AppFlowCoordinator
    
    init() {
        self.appFlowCoordinator = AppFlowCoordinator(appDIContainer: appDIContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            appFlowCoordinator.start()
        }
    }
}
