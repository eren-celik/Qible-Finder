//
//  FLTableViewCell.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

open class FLTableViewCell: UITableViewCell,
                            ReusableViewProtocol,
                            NibLoadableViewProtocol {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none;
    }
}
