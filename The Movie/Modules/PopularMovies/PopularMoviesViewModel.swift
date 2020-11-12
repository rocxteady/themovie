//
//  PopularMoviesViewModel.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import Foundation

typealias CompletionBlock = (_ error: String?) -> ()

class PopularMoviesViewModel {
    
    var movies = [Movie]()
    private let api = PopularMoviesAPI()
    private let parameters = PageRequestModel()
    
    init() {
        api.parameters = parameters
    }
    
    func getMovies(completion: @escaping CompletionBlock) {
        api.start { [weak self] (response) in
            if !response.success {
                completion(response.responseModel?.statusMessage ?? "Unkown Error")
            } else {
                self?.movies = response.responseModel?.results ?? []
                completion(nil)
            }
        }
    }
    
    func addRemoveFavorites(by movieId: Int, shouldAdd: Bool = true) {
        if let movie = movies.firstElement(by: movieId) {
            movie.isFavorite = shouldAdd
        }
    }

    deinit {
        api.end()
    }
}

extension PopularMoviesViewModel {
    
    func createDetailViewModel(at index: Int) -> MovieDetailViewModel {
        let movie = movies[index]
        return MovieDetailViewModel(movieId: movie.id)
    }
    
}
