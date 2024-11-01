//
//  LoadingHudManager.swift
//  FLBase
//
//  Created by Ugur Cakmakci on 27.04.2023.
//

import UIKit
//import MBProgressHUD

final class LoadingHudManager {
    public static let shared = LoadingHudManager()
    private init(){}
    
    func show(in view: UIView) {
//        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func dismiss(in view: UIView) {
//        MBProgressHUD.hide(for: view, animated: true)
    }
}

