//
//  CollectionView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit


class CollectionView: BaseNibLoadableView {
    @IBOutlet weak var collection: FLCollectionView!
    
    lazy var lineSpacing: CGFloat = 12
    lazy var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = lineSpacing
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        return layout
    }()
    
    func configure<T: FLCollectionViewCell>(delegate: UICollectionViewDelegate,
                                            dataSource: UICollectionViewDataSource,
                                            cell: T.Type,
                                            isScrollEnabled: Bool = true,
                                            scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                                            lineSpacing: CGFloat = 12) {
        
        self.scrollDirection = scrollDirection
        self.lineSpacing = lineSpacing
        collection.collectionViewLayout = self.flowLayout
        collection.register(cell.self)
        collection.delegate = delegate
        collection.dataSource = dataSource
        collection.isScrollEnabled = isScrollEnabled
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
    }
    
    func updateLayout(layout: UICollectionViewFlowLayout) {
        collection.collectionViewLayout = self.flowLayout
    }
    
    func registerHeader<T: UICollectionReusableView>(view: T.Type) {
        collection.register(view.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "header")
    }
    
    func reload() {
        collection.reloadData()
    }
}
