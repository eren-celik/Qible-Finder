//
//  QuickAccessView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit

protocol QuickAccessViewModelProtocol {
    var data: [Menu] { get set }
    var menuNavigation: MenuNavigationProtocol! { get set }
    var menuCoordinator: MenuCommonCoordinatorProtocol! { get set }
    var strings: GeneralStringProtocol! { get set }
}

struct QuickAccessViewModel: QuickAccessViewModelProtocol {
    var data: [Menu]
    var menuNavigation: MenuNavigationProtocol!
    var menuCoordinator: MenuCommonCoordinatorProtocol!
    var strings: GeneralStringProtocol!
    
    init(data: [Menu] = Menu.allMenu,
         menuNavigation: MenuNavigationProtocol!,
         menuCoordinator: MenuCommonCoordinatorProtocol!,
         strings: GeneralStringProtocol!) {
        self.data = data
        self.menuNavigation = menuNavigation
        self.menuCoordinator = menuCoordinator
        self.strings = strings
    }
}

class QuickAccessView: BaseNibLoadableView {
    @IBOutlet weak var titleLabelView: TitleLabelView!
    @IBOutlet weak var menuCollectionView: CollectionView!
    var viewModel: QuickAccessViewModelProtocol!
    
    func configure(with viewModel: QuickAccessViewModelProtocol) {
        self.viewModel = viewModel
        titleLabelView.configure(
            with: TitleLabelViewModel(
                title: self.viewModel.strings.quickAccessTitle,
                buttonTitle: self.viewModel.strings.all,
                buttonIsHidden: true,
                buttonHandler: allButtonHandler
            )
        )
        menuCollectionView.configure(delegate: self, dataSource: self, cell: QuickAccessMenuCell.self)
    }
    
    func allButtonHandler() {
        viewModel.menuNavigation.showMenu(menu: .all, coordinator: viewModel.menuCoordinator)
    }
}

extension QuickAccessView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.data[indexPath.row]
        viewModel.menuNavigation.showMenu(menu: selected, coordinator: viewModel.menuCoordinator)
    }
}

extension QuickAccessView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: QuickAccessMenuCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.data[indexPath.row]
        cell.setUI(data: data, strings: viewModel.strings)
        return cell
    }
}
