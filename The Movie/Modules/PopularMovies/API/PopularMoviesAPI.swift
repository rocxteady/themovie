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

    public typealias RequestModel = BaseRequestModel
        
    public var uri = "/movie/popular"
    
    public var endpoint: RestEndpoint
    
    public init() {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try! BaseRequestModel().toDictionary())
    }
    
}
