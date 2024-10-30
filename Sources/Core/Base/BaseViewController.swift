//
//  BaseViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import UIKit

class BaseViewController: UIViewController,
                          NavigationBarProtocol,
                          DismissDialogProtocol,
                          AlertPresentable {
    
    public convenience init() {
        let nibName: String = String(describing: Self.self)
        let bundle: Bundle? = Bundle(for: Self.self)
        self.init(nibName: nibName, bundle: bundle)
        self.view.backgroundColor = .grayBase
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
