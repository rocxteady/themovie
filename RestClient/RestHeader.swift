//
//  RestHeader.swift
//  RestClient
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

internal enum HeaderKeys: String {
    case contentType = "Content-Type"
}

internal enum ContentType: String {
    case url    = "application/x-www-form-urlencoded"
    case json   = "application/json"
}
