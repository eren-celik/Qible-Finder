//
//  LocationSelectCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 1.07.2024.
//

import Foundation



protocol LocationSelectCoordinatorProtocol: NavigationCoordinatorProtocol {
    var viewController: LocationSelectViewController { get }
}

class LocationSelectCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.present(viewController, animated: true)
    }
    
    func present(with locationSelectedHandler: VoidHandler?) {
        viewController.viewModel.locationSelectedHandler = locationSelectedHandler
        self.navigationController.present(viewController, animated: true)
    }

    lazy var viewController: LocationSelectViewController = {
        let controller = LocationSelectViewController()
        let viewModel = LocationSelectViewModel(endpoint: LocationSelectEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.strings = LocationSelectStrings()
        controller.viewModel.delegate = controller
        controller.setUI()
        return controller
    }()
}

extension LocationSelectCoordinator: LocationSelectCoordinatorProtocol {

}
