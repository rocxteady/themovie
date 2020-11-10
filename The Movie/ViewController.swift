//
//  ViewController.swift
//  The Movie
//
//  Created by Ulaş Sancak on 9.11.2020.
//

import UIKit
import RestClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let endpoint = RestEndpoint(urlString: "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=1")
        endpoint.start { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                print(data)
            }
        }
    }


}

