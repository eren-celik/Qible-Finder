//
//  MenuCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import Foundation


protocol MenuCoordinatorProtocol: MenuCommonCoordinatorProtocol {
    var viewController: MenuViewController { get }
}

class MenuCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }

    lazy var viewController: MenuViewController = {
        let controller = MenuViewController()
        let viewModel = MenuViewModel()
        controller.viewModel = viewModel
        controller.viewModel.strings = MenuStrings()
        controller.viewModel.coordinator = self
        return controller
    }()
}

extension MenuCoordinator: MenuCoordinatorProtocol {
    
}

