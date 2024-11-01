//
//  HadithCardView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import UIKit

protocol HadithCardViewModelProtocol {
    var data: [Hadith] { get set }
    var menuNavigation: MenuNavigationProtocol! { get set }
    var menuCoordinator: MenuCommonCoordinatorProtocol! { get set }
    var strings: GeneralStringProtocol! { get set }
}

struct HadithCardViewModel: HadithCardViewModelProtocol {
    var data: [Hadith] = []
    var menuNavigation: MenuNavigationProtocol!
    var menuCoordinator: MenuCommonCoordinatorProtocol!
    var strings: GeneralStringProtocol!
    
    init(menuNavigation: MenuNavigationProtocol!,
         menuCoordinator: MenuCommonCoordinatorProtocol!,
         strings: GeneralStringProtocol!) {
        self.menuNavigation = menuNavigation
        self.menuCoordinator = menuCoordinator
        self.strings = strings
    }
}

class HadithCardView: BaseNibLoadableView {
    @IBOutlet weak var titleLabelView: TitleLabelView!
    @IBOutlet weak var collectionView: CollectionView!
    
    var viewModel: HadithCardViewModelProtocol!
    
    func configure(with viewModel: HadithCardViewModelProtocol) {
        self.viewModel = viewModel
        titleLabelView.configure(
            with: TitleLabelViewModel(
                title: self.viewModel.strings.hadithDayTitle,
                buttonTitle: self.viewModel.strings.all,
                buttonIsHidden: false,
                buttonHandler: allButtonHandler
            )
        )
        collectionView.configure(delegate: self, dataSource: self, cell: HadithCardCell.self)
    }
    
    func updateUI(data: [Hadith]) {
        viewModel.data = data
        collectionView.reload()
    }
    
    func allButtonHandler() {
        viewModel.menuNavigation.showMenu(menu: .hadith, coordinator: viewModel.menuCoordinator)
    }
}

extension HadithCardView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selected = viewModel.data[indexPath.row]
        // selected item handling code here
    }
}

extension HadithCardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HadithCardCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.data = viewModel.data[indexPath.row]
        return cell
    }
}
