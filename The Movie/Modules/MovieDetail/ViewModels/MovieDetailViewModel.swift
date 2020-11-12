//
//  PopularMoviesViewModel.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import Foundation

class MovieDetailViewModel {
    
    var movieDetail: MovieDetail?
    private let api: MovieDetailAPI
    
    init(movieId: Int) {
        api = MovieDetailAPI(movieId: movieId)
    }
    
    func getMovieDetail(completion: @escaping CompletionBlock) {
        api.start { [weak self] (response) in
            if !response.success {
                completion(response.responseModel?.statusMessage ?? "Unkown Error")
            } else {
                self?.movieDetail = response.responseModel
                completion(nil)
            }
        }
    }
    
    deinit {
        api.end()
    }
}
