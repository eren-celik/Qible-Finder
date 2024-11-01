//
//  TabbarViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

protocol TabBarViewModelProtocol {
    var coordinator: TabBarCoordinatorProtocol! { get set }
    init(coordinator: TabBarCoordinatorProtocol!)
    func createControllers() -> [UIViewController]
    func generateNavigationController(withTitle title: String,
                                      withImage image: String,
                                      withSelectedImage selectedImage: String,
                                      withViewController viewController: UIViewController?) -> UINavigationController
}

class TabBarViewModel: TabBarViewModelProtocol {
    var coordinator: TabBarCoordinatorProtocol!
    
    required init(coordinator: TabBarCoordinatorProtocol!) {
        self.coordinator = coordinator
        
    }
    
    func createControllers() -> [UIViewController] {
        [
            generateNavigationController(withTitle: "Ana Sayfa", withImage: "icon_tabbar_home", withSelectedImage: "icon_tabbar_home_selected", withViewController: coordinator.homeController),
            generateNavigationController(withTitle: "Vakitler", withImage: "icon_tabbar_compass", withSelectedImage: "icon_tabbar_compass_selected", withViewController: coordinator.vakitlerController),
            generateNavigationController(withTitle: "Daha Fazla", withImage: "icon_tabbar_more", withSelectedImage: "icon_tabbar_more_selected", withViewController: coordinator.menuController)
        ]
    }
    
    func generateNavigationController(withTitle title: String,
                                      withImage image: String,
                                      withSelectedImage selectedImage: String,
                                      withViewController viewController: UIViewController?) -> UINavigationController {
        
        guard let viewController else { return UINavigationController() }
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = UIImage.namazAsset(named: image)
        navigationController.tabBarItem.selectedImage = UIImage.namazAsset(named: selectedImage)
        navigationController.tabBarItem.title = title
        return navigationController
    }
}
