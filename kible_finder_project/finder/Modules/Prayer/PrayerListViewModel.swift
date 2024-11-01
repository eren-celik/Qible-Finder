//
//  PrayerListViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import UIKit

protocol PrayerListBindingDelegate: BaseDisplayProtocol {
    func dataFetched()
}

protocol PrayerListViewModelProtocol {
    var endpoint: PrayerListEndpointProtocol! { get set }
    var coordinator: PrayerListCoordinatorProtocol! { get set }
    var delegate: PrayerListBindingDelegate! { get set }
    var strings: PrayerListStringProtocol! { get set }
    var data: [PrayerData]? { get set}
    var sections: [PrayerSection] { get set}
    init(endpoint: PrayerListEndpointProtocol)
    func serviceGet()
    func updateFlowLayout(_ flowLayout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout
}

class PrayerListViewModel: PrayerListViewModelProtocol {
    var endpoint: PrayerListEndpointProtocol!
    var coordinator: PrayerListCoordinatorProtocol!
    weak var delegate: PrayerListBindingDelegate!
    var strings: PrayerListStringProtocol!
    var data: [PrayerData]?
    var sections: [PrayerSection] = []
    
    required init(endpoint: PrayerListEndpointProtocol = PrayerListEndpoint()) {
        self.endpoint = endpoint
    }
    
    func serviceGet() {
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                data = try await endpoint?.prayers.retrieve()
                createSections()
                await MainActor.run {
                    delegate?.dataFetched()
                    delegate?.endLoading()
                }
                
            } catch let error {
                await MainActor.run {
                    delegate?.endLoading()
                    delegate?.display(error: error)
                }
            }
        }
    }
    
    func updateFlowLayout(_ flowLayout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout {
        let flowLayout = flowLayout
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        return flowLayout
    }
    
    func createSections() {
        guard let data else { return }
        data.forEach { prayer in
            sections.append(PrayerSection(title: prayer.title ?? "",
                                          desc: prayer.desc ?? "",
                                          items: prayer.prayers ?? [],
                                          isExpanded: false))
        }
    }
}

protocol PrayerListStringProtocol: GeneralStringProtocol {
}

struct PrayerListStrings: PrayerListStringProtocol {
}
