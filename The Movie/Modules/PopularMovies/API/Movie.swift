//
//  Movie.swift
//  The Movie
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation
import API

class Movie: Decodable {
    
    var id = 0
    var title = ""
    private var posterPath = ""
    private var backdropPath = ""
    
    var smallPoster: String {
        return Properties.baseFileURL + "/w185" + posterPath
    }
    
    var originalPoster: String {
        return Properties.baseFileURL + "/original" + posterPath
    }
    
    var smallBackdrop: String {
        return Properties.baseFileURL + "/w300" + backdropPath
    }
    
    var originalBackdrop: String {
        return Properties.baseFileURL + "/original" + backdropPath
    }
    
    var isFavorite: Bool {
        get {
            return FavoriteMovieManager.sharedManager.isFavorite(movieId: id)
        }
        set {
            newValue ? FavoriteMovieManager.sharedManager.add(movieId: id) : FavoriteMovieManager.sharedManager.remove(movieId: id)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
   }

}

extension Array where Element: Movie {
    
    func firstElement(by id: Int) -> Element? {
        guard let firstIndex = (firstIndex { (element) -> Bool in
            return element.id == id
        }) else { return nil }
        return self[firstIndex]
    }

}
