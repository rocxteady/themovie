//
//  RestError.swift
//  RestClient
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public enum RestError: Error {
    
    case badURL
    case badHost
    case jsonSerialization(error: Error?)
    case urlSession(error: Error?)
    case data(data: Data)
    case unknown
    
}
