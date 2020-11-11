//
//  UIImageView+URL.swift
//  The Movie
//
//  Created by Ulaş Sancak on 12.11.2020.
//

import UIKit

class AsyncImageView: UIImageView {
    
    private var session: URLSession!
    private var task: URLSessionTask? {
        willSet {
            task?.cancel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = URLCache.shared
        session = URLSession(configuration: config)
    }
    
}

extension AsyncImageView {
    func set(url: URL) {
        task = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        })
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
