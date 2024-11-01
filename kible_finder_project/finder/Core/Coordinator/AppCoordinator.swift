//
//  AppCoordinator.swift
//  Flight
//
//  Created by Ugur Cakmakci on 9.04.2024.
//

import UIKit


class AppCoordinator: BaseCoordinator {
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        super.init(with: BaseNavigationController())
    }

    override func start() {
        guard let window else { return }
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
}
