//
//  RestClient.swift
//  RestClient
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

/// The states of the requets.
public enum RestClientState: Int {
    
    case idle
    
    case running

    case suspended

    case completed
    
}

/// HTTP method types
public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

/// The protocol to declare a class/struct to be used in RestClientManager to start a request.
public protocol RestEndpointProtocol {
    
    var state: RestClientState { get }
    var encodingType: RestEncodingType { get }
    var httpMethod: HTTPMethod { get }
    var urlString: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    func start(completion: @escaping RestClientResponse)
    func end()
}

/// A basic class for using to start the request that conforms to RestEndpointProtocol
open class RestEndpoint: RestEndpointProtocol {
    
    private let restClientManager = RestClientManager()
        
    public var state: RestClientState {
        return restClientManager.state
    }
    
    public var encodingType: RestEncodingType = .url
    
    public var httpMethod: HTTPMethod = .get
    
    public var urlString: String
    
    public var parameters: [String : Any]?
    
    public var headers: [String : String]?
    
    /// Start the request.
    /// - Parameter completion: Completion block
    public func start(completion: @escaping RestClientResponse) {
        restClientManager.start(endpoint: self, completion: completion)
    }
    
    /// End the request.
    public func end() {
        restClientManager.end()
    }
    
    /// Return a RestEndpoint object using a URL.
    /// - Parameters:
    ///   - urlString: URL to send request with
    ///   - httpMethod: HTTP method type
    ///   - encodingType: Encoding type
    ///   - parameters: Request parameters
    ///   - headers: Request headers
    public init(urlString: String, httpMethod: HTTPMethod = .get, encodingType: RestEncodingType = .url, parameters: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.urlString = urlString
        self.httpMethod = httpMethod
        self.encodingType = encodingType
        self.parameters = parameters
        self.headers = headers
    }
    
}

//MARK: Helper methods to create a request.
internal extension RestEndpoint {
    
    /// Return a URLComponents instance to be used for URLRequest.
    /// - Throws: Throws and error if the given parameters is somehow wrong.
    /// - Returns: URLComponent instance which uses the parameters.
    func createURLComponents() throws -> URLComponents? {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw RestError.badURL
        }
        guard urlComponents.host != nil else {
            throw RestError.badHost
        }
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for parameter in parameters {
                queryItems.append(URLQueryItem(name: parameter.key, value: "\(parameter.value)"))
            }
            urlComponents.queryItems = queryItems
        }
        return urlComponents
    }
    
    /// Create a URL instance.
    /// - Throws: Throws and error if the given parameters is somehow wrong.
    /// - Returns: URL instance.
    func createURL() throws -> URL? {
        guard let url = URL(string: urlString) else {
            throw RestError.badURL
        }
        return url
    }
    
    /// Return a JSON Data instance from the parameters.
    /// - Throws: Throws and error if the given parameters is somehow wrong.
    /// - Returns: JSON Data instance.
    func createJSONData() throws -> Data? {
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                return data
            } catch let error {
                throw RestError.jsonSerialization(error: error)
            }
        }
        return nil
    }
    
    /// Create a URLRequest object if everything is fine.
    /// - Throws: Throws and error if the given parameters is somehow wrong.
    /// - Returns: URLRequest instance.
    func createRequest() throws -> URLRequest? {
        guard let urlComponents = try createURLComponents() else { return nil}
        switch httpMethod {
        case .get, .delete:
            guard let url = urlComponents.url else { return nil}
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = httpMethod.rawValue
            return request
        case .post, .put:
            guard let url = try createURL() else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = httpMethod.rawValue
            switch encodingType {
            case .url:
                request.addValue(ContentType.url.rawValue, forHTTPHeaderField: HeaderKeys.contentType.rawValue)
                if let body = urlComponents.percentEncodedQuery?.data(using: .utf8) {
                    request.httpBody = body
                }
                return request
            case .json:
                request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HeaderKeys.contentType.rawValue)
                if let data = try createJSONData() {
                    request.httpBody = data
                }
                return request
            }
        }
    }
    
}
