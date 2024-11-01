//
//  TableView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit


class TableView: BaseNibLoadableView {
    @IBOutlet weak var table: FLTableView!
        
    func configure<T: FLTableViewCell>(delegate: UITableViewDelegate,
                                       dataSource: UITableViewDataSource,
                                       cell: T.Type? = nil,
                                       isScrollEnabled: Bool = true) {
        
        if let cell {
            registerCell(cell)
        }
        
        table.separatorStyle = .none
        table.delegate = delegate
        table.dataSource = dataSource
        table.isScrollEnabled = isScrollEnabled
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
    }
    
    func registerCell<T: FLTableViewCell>(_ cell: T.Type) {
        table.register(cell)
    }
    
    func reload() {
        table.reloadData()
    }
}
