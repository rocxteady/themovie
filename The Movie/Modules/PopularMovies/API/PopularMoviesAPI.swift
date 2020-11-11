//
//  PopularMoviesAPI.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import API
import RestClient

class PopularMoviesAPI: API {
    
    public typealias ResponseModel = PageResponseModel<Movie>

    public typealias RequestModel = PageRequestModel
        
    public var uri = "/movie/popular"
    
    public var endpoint: RestEndpoint
    
    public var parameters: RequestModel? {
        didSet {
            endpoint.parameters = try? parameters?.toDictionary()
        }
    }
    
    public init(parameters: RequestModel? = nil) {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try? parameters.toDictionary())
        self.parameters = parameters
    }
    
}
