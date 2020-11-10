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
        let api = PopularMoviesAPI()
        api.start { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            else {
                print(response)
            }
        }
    }


}

