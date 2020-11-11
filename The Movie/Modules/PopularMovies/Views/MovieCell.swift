//
//  MovieCell.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    var imageView: AsyncImageView!
    var titleLabel: UILabel!
    var favoriteButton: UIButton!
    var titleView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        imageView = AsyncImageView(frame: bounds)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFill
        
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .systemBackground
        
        titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .label
        
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        
        favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 8.0).isActive = true

        titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8.0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 2.0).isActive = true
        titleView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.0).isActive = true
    }
    
}

extension MovieCell {
    
    func configure(movie: Movie) {
        titleLabel.text = "Hop"
        imageView.image = nil
        imageView.set(url: URL(string: "https://www.cicekdiyari.com/buyukresim/bisiklette-cicek-tasarim-cicek-resim.jpg")!)
    }
    
}
