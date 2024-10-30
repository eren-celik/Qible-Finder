//
//  LoadingDisplayProtocol.swift
//  FLBase
//
//  Created by Ugur Cakmakci on 18.04.2023.
//

import UIKit

public protocol BaseLoadingDisplayProtocol: AnyObject {
    func startLoading()
    func endLoading()
}

extension BaseLoadingDisplayProtocol where Self: UIViewController {
    public func startLoading() {
        DispatchQueue.main.async {
            LoadingHudManager.shared.show(in: self.view)
        }
    }
    public func endLoading() {
        DispatchQueue.main.async {
            LoadingHudManager.shared.dismiss(in: self.view)
        }
    }
}

extension BaseLoadingDisplayProtocol where Self: UIView {
    public func startLoading() {
        DispatchQueue.main.async {
            LoadingHudManager.shared.show(in: self)
        }
    }
    public func endLoading() {
        DispatchQueue.main.async {
            LoadingHudManager.shared.dismiss(in: self)
        }
    }
}
