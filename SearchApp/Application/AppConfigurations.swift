//
//  APpConfigurations.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import Foundation

final class AppConfigurations {
    lazy var apikey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Apikey") as? String else {
            fatalError("Apikey must not be empty in plist")
        }
        
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseUrl must not be empty")
        }
        
        return apiBaseURL
    }()
}
