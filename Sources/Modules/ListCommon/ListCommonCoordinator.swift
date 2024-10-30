//
//  MessageCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import Foundation

protocol ListCommonCoordinatorProtocol: NavigationCoordinatorProtocol {
    var viewController: ListCommonViewController { get }
}

class ListCommonCoordinator: BaseCoordinator {
    override func start() {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func push<T: FLTableViewCell>(with type: ListType, cell: T.Type) {
        viewController.viewModel?.type = type
        viewController.setUI(cell: cell)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    lazy var viewController: ListCommonViewController = {
        let controller = ListCommonViewController()
        let viewModel = ListCommonViewModel(endpoint: ListCommonEndpoint())
        controller.viewModel = viewModel
        controller.viewModel.coordinator = self
        controller.viewModel.strings = ListCommonStrings()
        controller.viewModel.delegate = controller
        
        return controller
    }()
}

extension ListCommonCoordinator: ListCommonCoordinatorProtocol {}
