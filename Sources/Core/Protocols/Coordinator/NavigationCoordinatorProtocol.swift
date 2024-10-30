//
//  NavigationCoordinatorProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import Foundation


public protocol NavigationCoordinatorProtocol {
    func goToBack(with animation: Bool)
}

public extension NavigationCoordinatorProtocol where Self: NavigationCoordinatorProtocol & BaseCoordinator {
    func goToBack(with animation: Bool = true) {
        self.navigationController.popViewController(animated: animation)
    }
}
