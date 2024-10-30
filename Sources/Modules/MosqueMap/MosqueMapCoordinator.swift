//
//  MosqueMapCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import Foundation


protocol MosqueMapCoordinatorProtocol: NavigationCoordinatorProtocol {
    var viewController: MosqueMapViewController { get }
}

class MosqueMapCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    lazy var viewController: MosqueMapViewController = {
        let controller = MosqueMapViewController()
        let viewModel = MosqueMapViewModel(endpoint: MosqueMapEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.strings = MosqueMapStrings()
        controller.viewModel.delegate = controller
        controller.setUI()
        return controller
    }()
}

extension MosqueMapCoordinator: MosqueMapCoordinatorProtocol {}
