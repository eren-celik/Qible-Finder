//
//  LocationListView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 2.07.2024.
//

import UIKit


protocol LocationListViewModelProtocol {
    var strings: LocationSelectStringProtocol { get }
    var tableData: [AppLocation] { get set }
    var filteredData: [AppLocation] { get set }
    var addedData: [AppLocation] { get set }
    var isSearching: Bool { get set }
    var locationHandler: VoidHandler? { get set }
    var locationAddedHandler: VoidHandler? { get set }
    func search(text: String) async
    func addLocation(data: AppLocation)
    func isLocationSelected(_ location: AppLocation) -> Bool
}

class LocationListViewModel: LocationListViewModelProtocol {
    var strings: LocationSelectStringProtocol
    var tableData: [AppLocation] = []
    var filteredData: [AppLocation] = []
    var addedData: [AppLocation] = UserDefaultsManager.shared.locations
    var isSearching: Bool = false
    var locationHandler: VoidHandler? = nil
    var locationAddedHandler: VoidHandler? = nil
    
    init(strings: LocationSelectStringProtocol,
         locationHandler: VoidHandler?,
         locationAddedHandler: VoidHandler?) {
        self.strings = strings
        self.locationHandler = locationHandler
        self.locationAddedHandler = locationAddedHandler
    }
    
    func search(text: String) async {
        let filtered = tableData.filter { location in
            let cityMatches = location.city?.localizedCaseInsensitiveContains(text) ?? false
            let districtMatches = location.district?.localizedCaseInsensitiveContains(text) ?? false
            return cityMatches || districtMatches
        }
        filteredData = text.isEmpty ? addedData : filtered
        isSearching = !text.isEmpty
    }
    
    func addLocation(data: AppLocation) {
        UserDefaultsManager.shared.addLocation(data)
        addedData = UserDefaultsManager.shared.locations
    }
    
    func isLocationSelected(_ location: AppLocation) -> Bool {
        guard !isSearching, let selectedLocation = UserDefaultsManager.shared.selectedLocation else { return false }
        return location == selectedLocation
    }
}

class LocationListView: BaseNibLoadableView {
    
    @IBOutlet private weak var titleLabel: Label!
    @IBOutlet private weak var searchTextField: TextField!
    @IBOutlet weak var tableView: TableView!
    
    var viewModel: LocationListViewModelProtocol!
    
    func configure(with viewModel: LocationListViewModelProtocol) {
        self.viewModel = viewModel
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        searchTextField.configure(with:
                .init(placeholder: viewModel.strings.placeholderAddLocation,
                      leftIcon: UIImage.iconSearch,
                      paddingLeftIcon: 12,
                      textPadding: leftPadding30))
        titleLabel.configure(with: .init(text: viewModel.strings.locationManuelTitle, font: .xs3Medium, textColor: .black100))
        tableView.configure(delegate: self, dataSource: self, cell: LocationCell.self)
        updateTableData()
    }
    
    func setData(data: [AppLocation]?) {
        viewModel.tableData = data ?? []
    }
    
    private func cellSelected(data: AppLocation?) {
        guard UserDefaultsManager.shared.selectedLocation != data else { return }
        UserDefaultsManager.shared.selectedLocation = data
        viewModel.locationHandler?()
    }
    
    private func addLocation(data: AppLocation?) {
        guard let data else { return }
        viewModel.isSearching = false
        viewModel.addLocation(data: data)
        viewModel.locationAddedHandler?()
        updateTableData()
    }
    
    public func updateTableData() {
        clearText()
        viewModel.filteredData = viewModel.isSearching ? [] : viewModel.addedData
        tableView.reload()
    }
    
    private func clearText() {
        searchTextField.text = ""
    }
    
    @objc private func textChanged() {
        guard let searchText = searchTextField.text else { return }
        performSearchAndReload(text: searchText)
    }
    
    private func performSearchAndReload(text: String) {
        Task {
            await viewModel.search(text: text)
            tableView.reload()
        }
    }
}

extension LocationListView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.updateStyle(.selected)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.updateStyle(.defaultt)
    }
}

// MARK: - UITableViewDelegate
extension LocationListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.filteredData[indexPath.row]
        if viewModel.isSearching {
            addLocation(data: data)
        } else {
            cellSelected(data: data)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let locationToRemove = viewModel.filteredData[indexPath.row]
        
        // Check if the location is the selected location
        if viewModel.isLocationSelected(locationToRemove) {
            return nil // Disable swipe actions for selected item
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: viewModel.strings.delete) { (action, view, completion) in
            UserDefaultsManager.shared.removeLocation(locationToRemove)
            
            self.viewModel.addedData = UserDefaultsManager.shared.locations
            self.viewModel.filteredData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        
        deleteAction.backgroundColor = .appRed
        deleteAction.image = UIImage.iconDelete
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
}

// MARK: - UITableViewDataSource
extension LocationListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationCell = tableView.dequeueReusableCell(for: indexPath)
        let data = viewModel.filteredData[indexPath.row]
        cell.data = data
        cell.isSearching = viewModel.isSearching
        cell.isSelect = viewModel.isLocationSelected(data)
        cell.clickedHandler = cellSelected
        return cell
    }
}
