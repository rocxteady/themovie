//
//  Movie.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

class Movie: BaseResponseModel {
    
    var popularity = 0.0
    
    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
   }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0

        try super.init(from: decoder)
    }
}
