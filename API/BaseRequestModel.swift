//
//  BaseRequestModel.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

open class BaseRequestModel: Encodable {
    
    var apiKey = Properties.apiKey
    
    var language = "en-US"
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language = "language"
    }
}
