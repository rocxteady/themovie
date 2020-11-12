//
//  MovieDetailViewController.swift
//  The Movie
//
//  Created by Ulaş Sancak on 12.11.2020.
//

import UIKit

typealias AddRemoveFavoriteCallback = (_ movieId: Int, _ shouldAdd: Bool) -> ()

class MovieDetailViewController: UIViewController {
    
    let viewModel: MovieDetailViewModel

    //MARK: UI Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: AsyncImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    var favoriteButton: UIBarButtonItem!
    
    //MARK: Callback
    var addRemoveFavoriteCallback: AddRemoveFavoriteCallback?
    
    //MARK: Initializations
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Content Detail"
        refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getMovileDetail(shouldShowActivityIndicator:)), for: .valueChanged)
        favoriteButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(addRemoveFavorite))
        favoriteButton.isEnabled = false
        navigationItem.rightBarButtonItem = favoriteButton
        getMovileDetail(shouldShowActivityIndicator: true)
    }
    
    private func checkIfFavorited() {
        favoriteButton.image = (viewModel.movieDetail?.isFavorite ?? false) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }

}

//MARK: Actions
extension MovieDetailViewController {
    @objc func addRemoveFavorite() {
        guard let movieDetail = viewModel.movieDetail else { return }
        addRemoveFavoriteCallback?(movieDetail.id, !movieDetail.isFavorite)
        checkIfFavorited()
    }
}

//MARK: API Handler
extension MovieDetailViewController {
    
    @objc func getMovileDetail(shouldShowActivityIndicator: Bool = false) {
        if shouldShowActivityIndicator {
            activityIndicator.startAnimating()
        }
        viewModel.getMovieDetail { [weak self] (error) in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            if let error = error {
                self?.showAlert(title: "Error", message: error)
            }
            else {
                self?.configure()
            }
        }
    }
    
    func configure() {
        guard let movieDetail = viewModel.movieDetail else { return }
        favoriteButton.isEnabled = true
        checkIfFavorited()
        if let url = URL(string: movieDetail.originalBackdrop) {
            imageView.set(url: url)
        }
        titleLabel.text = movieDetail.title
        descriptionLabel.text = movieDetail.overview
    }
    
}
