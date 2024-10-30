//
//  UICollectionViewExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

extension UICollectionView {
    
    public func safeScrollToItem(at indexPath: IndexPath,
                                 at scrollPosition: UICollectionView.ScrollPosition,
                                 animated: Bool) {
        guard indexPath.item >= 0,
              indexPath.section >= 0,
              indexPath.section < numberOfSections,
              indexPath.item < numberOfItems(inSection: indexPath.section)
        else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableViewProtocol {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func register<T: UICollectionViewCell>(_: T.Type)
    where T: ReusableViewProtocol, T: NibLoadableViewProtocol {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func registerHeader<T: UICollectionReusableView>(_: T.Type)
    where T: ReusableViewProtocol {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func registerFooter<T: UICollectionReusableView>(_: T.Type)
    where T: ReusableViewProtocol {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T
    where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, type: T.Type) -> T
    where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, type: T.Type) -> T
    where T: ReusableViewProtocol {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                       withReuseIdentifier: T.defaultReuseIdentifier,
                                                                       for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.defaultReuseIdentifier)")
        }
        return supplementaryView
    }
}
