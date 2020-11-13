//
//  PopularMoviesViewController.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import UIKit

class PopularMoviesViewController: UICollectionViewController {
    
    let viewModel = PopularMoviesViewModel()
    
    //MARK: UI Properties
    var layoutChangeButton: UIBarButtonItem!
    var layout: MoviesLayout {
        return collectionView.collectionViewLayout as! MoviesLayout
    }
    var refreshControl: UIRefreshControl!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    //MARK: Initializations
    init() {
        super.init(collectionViewLayout: MoviesLayout())
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: UI Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contents"
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        layoutChangeButton = UIBarButtonItem(image: layout.type.image, style: .plain, target: self, action: #selector(changeLayout))
        navigationItem.setRightBarButton(layoutChangeButton, animated: false)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getMovies), for: .valueChanged)
        
        getMovies(shouldShowActivityIndicator: true)
    }
    
    //MARK: UICollectionView Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = viewModel.movies[indexPath.row]
        cell.configure(movie: movie, layoutType: layout.type)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.imageView.cancel()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController(viewModel: viewModel.createDetailViewModel(at: indexPath.row))
        movieDetailViewController.addRemoveFavoriteCallback = { [weak self] (movieId, shouldAdd) in
            self?.viewModel.addRemoveFavorites(by: movieId, shouldAdd: shouldAdd)
            self?.collectionView.reloadData()
        }
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}

//MARK: UICollectionView Layout Delegate
extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionView.collectionViewLayout as? MoviesLayout)?.itemSize ?? .zero
    }
    
}

//MARK: Actions
extension PopularMoviesViewController {
    @objc private func changeLayout() {
        layout.toggle()
        layoutChangeButton.image = layout.type.image
        collectionView.reloadData()
    }

}

//MARK: API Handler
extension PopularMoviesViewController {
    
    @objc private func getMovies(shouldShowActivityIndicator: Bool = false) {
        if shouldShowActivityIndicator {
            activityIndicator.startAnimating()
        }
        viewModel.getMovies { [weak self] (error) in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            if let error = error {
                self?.showAlert(title: "Error", message: error)
            } else {
                self?.collectionView.reloadData()
            }
        }
    }
    
}
