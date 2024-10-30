//
//  BaseCoordinator.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import UIKit

public protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    var tabBarController: UITabBarController? { get }
    func start()
}

open class BaseCoordinator: CoordinatorProtocol {
    public var navigationController: UINavigationController = .init()
    public var tabBarController: UITabBarController? = nil
    
    open func start() {}
    public init() {}
    public init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    public init(with navigationController: UINavigationController, tabBarController: UITabBarController? = nil) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
}
