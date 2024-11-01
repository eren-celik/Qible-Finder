//
//  BaseNavigationController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        // Setup navigation bar appearance
        setupNavigationBarAppearance()
    }
 
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.whiteBase]
        appearance.backgroundColor = .primaryBase
        if let backImage = UIImage.namazAsset(named: "icon_back")?.withRenderingMode(.alwaysOriginal) {
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        }
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        // Hide back button text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        // No need to repeat appearance setup here since it's already done in viewDidLoad
        
        // Hide back button text for the new view controller
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
