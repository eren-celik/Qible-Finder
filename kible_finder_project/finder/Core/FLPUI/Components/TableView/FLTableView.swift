//
//  FLTableView.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

open class FLTableView: UITableView {
    
    open override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
