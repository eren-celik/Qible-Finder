//
//  MenuViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit

class MenuViewController: BaseViewController {
    var viewModel: MenuViewModelProtocol!
    
    @IBOutlet weak var tableview: TableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.configure(delegate: self, 
                            dataSource: self,
                            cell: MenuCell.self)      
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.data[indexPath.row]
        viewModel.showMenu(menu: selected, coordinator: viewModel.coordinator)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tableView.dequeueReusableCell(for: indexPath)
        let data = viewModel.data[indexPath.row]
        cell.setUI(data: data, strings: viewModel.strings)
        return cell
    }
}
