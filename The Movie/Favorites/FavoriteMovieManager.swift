//
//  FavoriteMovieManager.swift
//  The Movie
//
//  Created by Ulaş Sancak on 12.11.2020.
//

import Foundation

class FavoriteMovieManager {
    
    static let sharedManager = FavoriteMovieManager()
    
    private static let userDefaultsKey = "favoriteMovieIds"
    
    private var favoriteMovieIds = Set<Int>()
    
    init() {
        if let array = UserDefaults.standard.object(forKey: FavoriteMovieManager.userDefaultsKey) as? [Int] {
            favoriteMovieIds = Set(array.map { $0 })
        }
    }
    
    func save() {
        let array = Array(favoriteMovieIds)
        UserDefaults.standard.setValue(array, forKey: FavoriteMovieManager.userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
}

extension FavoriteMovieManager {
    
    func isFavorite(movieId: Int) -> Bool {
        return favoriteMovieIds.contains(movieId)
    }
    
    func add(movieId: Int) {
        favoriteMovieIds.insert(movieId)
        save()
    }
    
    func remove(movieId: Int) {
        favoriteMovieIds.remove(movieId)
        save()
    }
    
}
