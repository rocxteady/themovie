//
//  PopularMoviesAPI.swift
//  The Movie
//
//  Created by Ulaş Sancak on 12.11.2020.
//

import Foundation
import API
import RestClient

class MovieDetailAPI: API {
    
    public typealias ResponseModel = MovieDetail

    public typealias RequestModel = BaseRequestModel
        
    public var uri = "/movie"
    
    public var endpoint: RestEndpoint
    
    public var parameters: RequestModel {
        didSet {
            endpoint.parameters = try? parameters.toDictionary()
        }
    }
    
    public init(movieId: Int, parameters: RequestModel = RequestModel()) {
        uri += "/\(movieId)"
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try? parameters.toDictionary())
        self.parameters = parameters
    }
    
}
