//
//  PrayerListViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import UIKit

class PrayerListViewController: BaseViewController {
    var viewModel: PrayerListViewModelProtocol!
    
    @IBOutlet weak var collectionView: CollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUI() {
        collectionView.configure(delegate: self,
                                 dataSource: self,
                                 cell: PrayerAccordionCell.self,
                                 scrollDirection: .vertical)
        collectionView.registerHeader(view: PrayerAccordionHeaderView.self)
        collectionView.updateLayout(layout: viewModel.updateFlowLayout(collectionView.flowLayout))
        viewModel.serviceGet()
    }
    
    func handleExpandClose(section: Int) {
        viewModel.sections[section].isExpanded.toggle()
        collectionView.collection.reloadSections(IndexSet(integer: section))
    }
}

extension PrayerListViewController: PrayerListBindingDelegate {
    func dataFetched() {
        collectionView.reload()
    }
}

extension PrayerListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension PrayerListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].isExpanded ? viewModel.sections[section].items.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PrayerAccordionCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.sections[indexPath.section].items[indexPath.row]
        cell.isLastCell = indexPath.row == viewModel.sections[indexPath.section].items.count - 1
        cell.data = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? PrayerAccordionHeaderView else {
            fatalError("HeaderView could not be dequeued")
        }
        headerView.data = viewModel.sections[indexPath.section]
        headerView.section = indexPath.section
        headerView.enpandActionHandler = handleExpandClose
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
