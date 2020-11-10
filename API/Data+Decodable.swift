//
//  Data+Decodable.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

extension Data {
    func toDecodable<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}
