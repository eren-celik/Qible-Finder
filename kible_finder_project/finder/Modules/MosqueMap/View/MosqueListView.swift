//
//  MosqueListView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 19.07.2024.
//

import UIKit


protocol MosqueListViewModelProtocol {
    var data: [MosqueMap] { get set }
    var tableData: [MosqueMap] { get set }
    var strings: MosqueMapStringProtocol! { get set }
    var dismissHandler: VoidHandler! { get set }
    var routeHandler: MosqueMapHandler! { get set }
    var shareHandler: MosqueMapHandler! { get set }
    func search(text: String) async
}

class MosqueListViewModel: MosqueListViewModelProtocol {
    var data: [MosqueMap] = []
    var tableData: [MosqueMap] = []
    var strings: MosqueMapStringProtocol!
    var dismissHandler: VoidHandler!
    var routeHandler: MosqueMapHandler!
    var shareHandler: MosqueMapHandler!
    
    init(data: [MosqueMap], strings: MosqueMapStringProtocol!, dismissHandler: VoidHandler!, routeHandler: MosqueMapHandler!, shareHandler: MosqueMapHandler!) {
        self.data = data
        self.tableData = data
        self.strings = strings
        self.dismissHandler = dismissHandler
        self.routeHandler = routeHandler
        self.shareHandler = shareHandler
    }
    
    func search(text: String) async {
        let filtered = data.filter { model in
            let nameMatches = model.name?.localizedCaseInsensitiveContains(text) ?? false
            let addessMatches = model.address?.localizedCaseInsensitiveContains(text) ?? false
            return nameMatches || addessMatches
        }
        tableData = text.isEmpty ? data : filtered
    }
}

class MosqueListView: BaseNibLoadableView {
    var viewModel: MosqueListViewModelProtocol!
    
    @IBOutlet weak var mosqueCollectionView: CollectionView!
    @IBOutlet weak var mapButtonView: ListMapButtonView!
    @IBOutlet weak var searchTextField: TextField!
    
    func configure(with viewModel: MosqueListViewModelProtocol) {
        self.viewModel = viewModel
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        searchTextField.configure(with:
                .init(placeholder: viewModel.strings.placeholderSearchMosque,
                      leftIcon: UIImage.iconSearch,
                      paddingLeftIcon: 12,
                      textPadding: leftPadding30))
        
        mosqueCollectionView.configure(delegate: self, dataSource: self, cell: MosqueMapCell.self, scrollDirection: .vertical)
        mosqueCollectionView.updateLayout(layout: updateFlowLayout(mosqueCollectionView.flowLayout))
        mosqueCollectionView.reload()
        
        mapButtonView.configure(with: ListMapButtonViewModel(strings: viewModel.strings,
                                                             clickedHandler: viewModel.dismissHandler,
                                                             hideCenterMapButton: true))
    }
    
    func updateFlowLayout(_ flowLayout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout {
        let updatedFlowLayout = flowLayout
        updatedFlowLayout.sectionInset = .zero
        updatedFlowLayout.estimatedItemSize = .zero
        updatedFlowLayout.itemSize = CGSize(width: mosqueCollectionView.bounds.width-16, height: 170)
        return updatedFlowLayout
    }
    
    @objc private func textChanged() {
        guard let searchText = searchTextField.text else { return }
        performSearchAndReload(text: searchText)
    }
    
    private func performSearchAndReload(text: String) {
        Task {
            await viewModel.search(text: text)
            mosqueCollectionView.reload()
        }
    }
}

extension MosqueListView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.updateStyle(.selected)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.updateStyle(.defaultt)
    }
}


extension MosqueListView: UICollectionViewDelegate {}

extension MosqueListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MosqueMapCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.tableData[indexPath.row]
        cell.routeHandler = viewModel.routeHandler
        cell.shareHandler = viewModel.shareHandler
        cell.setUI(data: data, strings: viewModel.strings)
        return cell
    }
}
