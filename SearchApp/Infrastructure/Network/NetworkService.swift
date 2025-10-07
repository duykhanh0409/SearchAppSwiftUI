//
//  NetworkService.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: Equatable, LocalizedError {
        case invalidURL
        case badResponse(statusCode: Int)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "The provided URL is invalid."
            case .badResponse(let code):
                return "Bad response from server. Status code: \(code)"
            case .unknown:
                return "An unknown error occurred."
            }
        }
    }
    
    // MARK: - New method: fetch with cache + live data
    static func fetchWithCache(from urlString: String, method: String = "GET") -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.cachePolicy = .returnCacheDataDontLoad // chỉ lấy từ cache nếu có
        
        // 1️⃣ Get cached data first
        let cachedPublisher: AnyPublisher<Data, Error> = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(\.data)
            .catch { _ in Empty() } // không emit nếu không có cache
            .eraseToAnyPublisher()
        
        // 2️⃣ Then fetch live data
        var liveRequest = URLRequest(url: url)
        liveRequest.httpMethod = method
        liveRequest.cachePolicy = .reloadIgnoringLocalCacheData // buộc gọi lại API
        
        let freshPublisher: AnyPublisher<Data, Error> = URLSession.shared.dataTaskPublisher(for: liveRequest)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    throw NetworkingError.badResponse(statusCode: (element.response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return element.data
            }
            .eraseToAnyPublisher()
        
        // 3️⃣ Merge: cache → live
        return cachedPublisher
            .append(freshPublisher)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func fetchData(from urlString: String, method: String = "GET") -> AnyPublisher<Data, Error> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkingError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    let code = (element.response as? HTTPURLResponse)?.statusCode ?? -1
                    throw NetworkingError.badResponse(statusCode: code)
                }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(_ completion: Subscribers.Completion<Error>) -> String? {
        switch completion {
        case .finished:
            return nil
        case .failure(let error):
            return (error as? NetworkingError)?.localizedDescription ?? "An unknown error occurred."
        }
    }
}

