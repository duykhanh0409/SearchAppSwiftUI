//
//  AppDIContainer.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfigurations()
    
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: [
                "api_key" : appConfiguration.apikey,
                "language": NSLocale.preferredLanguages.first ?? "en"
            ]
        )
        
        let apiDataNetwork = NetworkingManager(config: config)
        return DefaultDataTransferService(
            networkService: apiDataNetwork
        )
    }()
    
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        let dependencies = MoviesSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService
        )
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
}
