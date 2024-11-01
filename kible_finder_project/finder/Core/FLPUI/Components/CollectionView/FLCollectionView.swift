//
//  FLUICollectionView.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

open class FLCollectionView: UICollectionView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
