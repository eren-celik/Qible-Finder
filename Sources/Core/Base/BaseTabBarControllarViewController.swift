//
//  BaseTabBarControllarViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setAppereance()
    }
    
    func setAppereance() {
        let colorPassive: UIColor = .blackBase
        let colorActive: UIColor = .primaryBase
        self.view.backgroundColor = .white
        let tabBarAppearance = UITabBar.appearance(whenContainedInInstancesOf: [TabBarViewController.self])
        tabBarAppearance.tintColor = colorActive
        tabBarAppearance.unselectedItemTintColor = colorPassive
        
        let tabBarItemAppearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarViewController.self])
        tabBarItemAppearance.setTitleTextAttributes([.foregroundColor: colorActive, .font: UIFont.xs4Bold], for: .selected)
        tabBarItemAppearance.setTitleTextAttributes([.foregroundColor: colorPassive, .font: UIFont.xs4Bold], for: .normal)
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .white200
            appearance.backgroundColor = .white100
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: colorActive, .font: UIFont.xs4Bold]
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: colorPassive, .font: UIFont.xs4Bold]
            itemAppearance.normal.iconColor = colorPassive
            itemAppearance.selected.iconColor = colorActive
            appearance.stackedLayoutAppearance = itemAppearance
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
