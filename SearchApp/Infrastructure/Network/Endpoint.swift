//
//  Endpoint.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation

protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

// MARK: - Response Decoders
class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}


class Endpoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    let path: String
    let isFullPath: Bool
    let method: HTTPMethodType
    let headerParameters: [String: String]
    let queryParametersEncodable: Encodable?
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable?
    let bodyParameters: [String: Any]
    let bodyEncoder: BodyEncoder
    let responseDecoder: ResponseDecoder
    
    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParametersEncodable: Encodable? = nil,
         bodyParameters: [String: Any] = [:],
         bodyEncoder: BodyEncoder = JSONBodyEncoder(),
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyEncoder = bodyEncoder
        self.responseDecoder = responseDecoder
    }
}

protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data?
}

struct JSONBodyEncoder: BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}

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
    var queryParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyEncoder: BodyEncoder { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

enum RequestGenerationError: Error {
    case components
}


extension Requestable {
    
    func url(with config: NetworkConfigurable) throws -> URL {
        
        let baseURL = config.baseURL.absoluteString.last != "/"
        ? config.baseURL.absoluteString + "/"
        : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents = URLComponents(
            string: endpoint
        ) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
        if !bodyParameters.isEmpty {
            urlRequest.httpBody = bodyEncoder.encode(bodyParameters)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}


private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
