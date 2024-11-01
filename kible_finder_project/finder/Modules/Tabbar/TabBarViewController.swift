//
//  TabbarViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

class TabBarViewController: BaseTabBarController {
    var viewModel: TabBarViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllers = viewModel.createControllers()
    }
}
