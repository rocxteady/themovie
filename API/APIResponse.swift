//
//  APIResponse.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public struct APIResponse<ResponseModel: Decodable> {
    public var responseModel: ResponseModel?
    public var success = false
    public var error: Error?
    public init() {}
}
