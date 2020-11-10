//
//  PageResponseModel.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

class PageResponseModel<Model: Decodable>: BaseResponseModel {
    
    var page = 0
    var totalResults = 0
    var totalPage = 0
    var results = [Model]()
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPage = "total_pages"
        case results = "results"
   }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        totalPage = try container.decodeIfPresent(Int.self, forKey: .totalPage) ?? 0
        results = try container.decodeIfPresent([Model].self, forKey: .results) ?? [Model]()

        try super.init(from: decoder)
    }
}
