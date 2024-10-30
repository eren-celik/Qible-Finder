//
//  HomeCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import Foundation



protocol HomeCoordinatorProtocol: NavigationCoordinatorProtocol, MenuCommonCoordinatorProtocol {
    var viewController: HomeViewController { get }
    func gotoVakitler()
    func showLocationRequest(with dismissHandler: VoidHandler?, locationSelectedHandler: VoidHandler?)
    func presentLocationSelection(with locationSelectedHandler: VoidHandler?)
}

class HomeCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }

    lazy var viewController: HomeViewController = {
        let controller = HomeViewController()
        let viewModel = HomeViewModel(endpoint: HomeEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.menuNavigation = MenuNavigation()
        controller.viewModel.coordinator = self
        controller.viewModel.strings = HomeStrings()
        controller.viewModel.delegate = controller
        controller.setUI()
        return controller
    }()
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func gotoVakitler() {
        let coordinator = VakitlerCoordinator(with: self.navigationController)
        coordinator.start()
    }
    
    func showLocationRequest(with dismissHandler: VoidHandler?, locationSelectedHandler: VoidHandler?) {
        let coordinator = LocationRequestCoordinator(with: self.navigationController)
        coordinator.present(with: dismissHandler, locationSelectedHandler: locationSelectedHandler)
    }
    
    func presentLocationSelection(with locationSelectedHandler: VoidHandler?) {
        let coordinator = LocationSelectCoordinator(with: self.navigationController)
        coordinator.present(with: locationSelectedHandler)
    }
}
