//
//  Movie.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import API

class MovieDetail: BaseResponseModel {
    
    var id = 0
    var title = ""
    var overview = ""
    private var backdropPath = ""
    
    var originalBackdrop: String {
        return Properties.baseFileURL + "/original" + backdropPath
    }
    
    var isFavorite: Bool {
        return FavoriteMovieManager.sharedManager.isFavorite(movieId: id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case backdropPath = "backdrop_path"
   }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""

        try super.init(from: decoder)
    }
}
