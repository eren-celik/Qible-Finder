//
//  VakitlerCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import Foundation


protocol VakitlerCoordinatorProtocol {
    var viewController: VakitlerViewController { get }
}

class VakitlerCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    lazy var viewController: VakitlerViewController = {
        let controller = VakitlerViewController()
        let viewModel = VakitlerViewModel(endpoint: VakitlerEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.delegate = controller
        return controller
    }()
}

extension VakitlerCoordinator: VakitlerCoordinatorProtocol {
}
