//
//  PopularMoviesViewController.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import UIKit

class PopularMoviesViewController: UICollectionViewController {
    
    let viewModel = PopularMoviesViewModel()
    var layoutChangeButton: UIBarButtonItem!
    var layout: MoviesLayout {
        return collectionView.collectionViewLayout as! MoviesLayout
    }

    init() {
        super.init(collectionViewLayout: MoviesLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutChangeButton = UIBarButtonItem(image: layout.type.image, style: .plain, target: self, action: #selector(changeLayout))
        navigationItem.setRightBarButton(layoutChangeButton, animated: false)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        getMovies()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = viewModel.movies[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    @objc private func changeLayout() {
        layout.toggle()
        layout.invalidateLayout()
        layoutChangeButton.image = layout.type.image
    }
    
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (collectionView.collectionViewLayout as? MoviesLayout)?.itemSize ?? .zero
    }
    
}

extension PopularMoviesViewController {
    
    private func getMovies() {
        viewModel.getMovies { [weak self] (error) in
            self?.collectionView.reloadData()
        }
    }
    
}
