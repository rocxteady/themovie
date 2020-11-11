//
//  PopularMoviesViewModel.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import Foundation

typealias CompletionBlock = (_ error: Error?) -> ()

class PopularMoviesViewModel {
    
    var movies = [Movie]()
    let api = PopularMoviesAPI()
    let parameters = PageRequestModel()
    
    init() {
        api.parameters = parameters
    }
    
    func getMovies(completion: @escaping CompletionBlock) {
        api.start { [weak self] (response) in
            if let error = response.error {
                completion(error)
            } else {
                self?.movies = response.responseModel?.results ?? []
                completion(nil)
            }
        }
    }
    
    deinit {
        api.end()
    }
}
