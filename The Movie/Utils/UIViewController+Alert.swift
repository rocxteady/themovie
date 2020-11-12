//
//  UIViewController+Alert.swift
//  The Movie
//
//  Created by Ulaş Sancak on 12.11.2020.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String? = nil, buttonTitle: String? = "OK") {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}
