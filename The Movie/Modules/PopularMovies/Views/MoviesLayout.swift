//
//  MoviesLayout.swift
//  The Movie
//
//  Created by Ulaş Sancak on 11.11.2020.
//

import UIKit

enum MoviesLayoutType {
    case list
    case grid
    
    var image: UIImage? {
        switch self {
        case .list:
            return UIImage(systemName: "square.grid.3x3")
        case .grid:
            return UIImage(systemName: "list.dash")
        }
    }
}

class MoviesLayout: UICollectionViewFlowLayout {
    
    var type: MoviesLayoutType = .list {
        didSet {
            if type != oldValue {
                arrangeItemSize()
            }
        }
    }
    
    private func arrangeItemSize() {
        switch type {
        case .list:
            itemSize = CGSize(width: UIScreen.main.bounds.width - sectionInset.left - sectionInset.right, height: 232.0)
        case .grid:
            itemSize = CGSize(width: (UIScreen.main.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing)/2.0, height: 303.0)
        }
    }

    override func prepare() {
        super.prepare()
        sectionInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        minimumLineSpacing = 16.0
        minimumInteritemSpacing = 8.0
        arrangeItemSize()
        sectionInsetReference = .fromSafeArea
    }
    
}

extension MoviesLayout {
    
    func toggle() {
        type = type == .list ? .grid : .list
        invalidateLayout()
    }
    
}
