//
//  BaseResponseModel.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

class BaseResponseModel: Decodable {
    
    public var statusCode: Int?
    public var statusMessage: String?
    public var success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success = "success"
    }
    
}
