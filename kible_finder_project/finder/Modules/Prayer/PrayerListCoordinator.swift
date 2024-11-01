//
//  PrayerListCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import Foundation


protocol PrayerListCoordinatorProtocol: NavigationCoordinatorProtocol {
    var viewController: PrayerListViewController { get }
}

class PrayerListCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    lazy var viewController: PrayerListViewController = {
        let controller = PrayerListViewController()
        let viewModel = PrayerListViewModel(endpoint: PrayerListEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.strings = PrayerListStrings()
        controller.viewModel.delegate = controller
        controller.setUI()
        return controller
    }()
}

extension PrayerListCoordinator: PrayerListCoordinatorProtocol {}
