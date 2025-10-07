//
//  Endpoint.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var queryParamterEncodable: Encodable? { get }
    var bodyParameter: [String: Any] { get }
    var bodyParameterEncodable: Encodable? { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}
