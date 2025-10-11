//
//  DataTransferService.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 11/10/25.
//

import Foundation
import Combine

protocol DataTransferService {
    func request<E: ResponseRequestable>(
        with endpoint: E
    ) -> AnyPublisher<E.Response, Error> where E.Response: Decodable
}

final class DefaultDataTransferService: DataTransferService {
    private let networkService: NetworkingManager
    
    init(networkService: NetworkingManager) {
        self.networkService = networkService
    }
}


extension DefaultDataTransferService {
    
    func request<E: ResponseRequestable>(
        with endpoint: E
    ) -> AnyPublisher<E.Response, Error> where E.Response: Decodable {
        return networkService.request(endpoint: endpoint)
            .tryMap { data in
                try endpoint.responseDecoder.decode(data)
            }
            .eraseToAnyPublisher()
    }
}
