//
//  API.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import RestClient

public typealias APIResponseCompletion<T: Decodable> = (APIResponse<T>) -> ()

public protocol API {
    associatedtype ResponseModel: Decodable
    associatedtype RequestModel: Encodable
    var uri: String { get set }
    var endpoint: RestEndpoint { get set }
    func start(completion: @escaping APIResponseCompletion<ResponseModel>)
    func end()
}

public extension API {
    func start(completion: @escaping APIResponseCompletion<ResponseModel>) {
        addHeaders()
        endpoint.start { (response) in
            var apiResponse = APIResponse<ResponseModel>()
            switch response {
            case .success(let data):
                do {
                    let responseModel: ResponseModel = try data.toDecodable()
                    apiResponse.responseModel = responseModel
                    apiResponse.success = true
                } catch let error {
                    apiResponse.error = error
                }
            case .failure(let error):
                apiResponse.error = error
            }
            completion(apiResponse)
        }
    }
    func end() {
        endpoint.end()
    }
}

private extension API {
    func addHeaders() {
        var headers = endpoint.headers ?? [:]
        headers.merge(Properties.headers)  { (current, _) in current }
        endpoint.headers = headers
    }
}
