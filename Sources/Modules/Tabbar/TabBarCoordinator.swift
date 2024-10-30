//
//  TabbarCoordinator.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit


protocol TabBarCoordinatorProtocol {
    var homeController: HomeViewController? { get }
    var vakitlerController: VakitlerViewController? { get }
    var menuController: MenuViewController? { get }
    var viewController: TabBarViewController? { get }
}

public class TabBarCoordinator: BaseCoordinator {
    var homeCoordinator: HomeCoordinatorProtocol?
    var vakitlerCoordinator: VakitlerCoordinatorProtocol?
    var menuCoordinator: MenuCoordinatorProtocol?
    private var window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    func createCoordonators() {
        homeCoordinator = HomeCoordinator(with: self.navigationController, tabBarController: viewController)
        vakitlerCoordinator = VakitlerCoordinator(with: navigationController, tabBarController: viewController)
        menuCoordinator = MenuCoordinator(with: navigationController, tabBarController: viewController)
    }
    
    public override func start() {
        guard let viewController else { return }
        let nav = BaseNavigationController(rootViewController: viewController)
        self.createCoordonators()
        self.window.rootViewController = nav
        self.window.makeKeyAndVisible()
    }
    
    lazy var viewController: TabBarViewController? = {
        let viewModel = TabBarViewModel(coordinator: self)
        let controller = TabBarViewController()
        controller.viewModel = viewModel
        return controller
    }()
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    var homeController: HomeViewController? {
        homeCoordinator?.viewController
    }
    var vakitlerController: VakitlerViewController? {
        vakitlerCoordinator?.viewController
    }
    var menuController: MenuViewController? {
        menuCoordinator?.viewController
    }
}
