//
//  LocationRequestCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 27.06.2024.
//

import Foundation



protocol LocationRequestCoordinatorProtocol: NavigationCoordinatorProtocol {
    var viewController: LocationRequestViewController { get }
    func presentLocationSelection()
    func showLocationSelection() -> LocationSelectViewController
}

class LocationRequestCoordinator: BaseCoordinator {
    override func start() {
        viewController.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(viewController, animated: true)
    }
    
    func present(with dismissHandler: VoidHandler?, locationSelectedHandler: VoidHandler?) {
        viewController.viewModel.dismissAndPresentLocationSelectHandler = dismissHandler
        viewController.viewModel.locationSelectedHandler = locationSelectedHandler
        viewController.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(viewController, animated: true)
    }

    lazy var viewController: LocationRequestViewController = {
        let controller = LocationRequestViewController()
        let viewModel = LocationRequestViewModel()
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.strings = LocationRequestStrings()
        controller.viewModel.delegate = controller
        controller.setUI()
        return controller
    }()
}

extension LocationRequestCoordinator: LocationRequestCoordinatorProtocol {
    func gotoVakitler() {
        let coordinator = VakitlerCoordinator(with: self.navigationController)
        coordinator.start()
    }
   
    func presentLocationSelection() {
        let coordinator = LocationSelectCoordinator(with: self.navigationController)
        coordinator.start()
    }
    
    func showLocationSelection() -> LocationSelectViewController {
        let coordinator = LocationSelectCoordinator(with: self.navigationController)
        return coordinator.viewController
    }
}
