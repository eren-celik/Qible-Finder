//
//  NavigationBarProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit


public protocol NavigationBarProtocol {
    func setLeftTitle(_ text: String?, font: UIFont)
    func setRightButton(clickAction: Selector, icon: String)
    func setLeftButton(clickAction: Selector, icon: String)
    func setRightCustomView(clickAction: Selector, view: UIView)
}

extension NavigationBarProtocol where Self: BaseViewController {
    func setLeftTitle(_ text: String?, font: UIFont = .xs2SemiBold) {
        let titleLabel = FLLabel()
        titleLabel.text = text
        titleLabel.font = font
        titleLabel.textColor = .whiteBase
        let item = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftItemsSupplementBackButton = true
        if navigationItem.leftBarButtonItems != nil {
            navigationItem.leftBarButtonItems?.removeAll()
            navigationItem.leftBarButtonItems?.append(item)
        } else {
            navigationItem.leftBarButtonItem = item
        }
    }
    
    func setRightButton(clickAction: Selector, icon: String) {
        let item = UIBarButtonItem(
            image: UIImage(named: icon, in: Bundle(identifier: "demiroren.kible-finder"), compatibleWith: nil)?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: clickAction)
        // Sağ bar button item'ı kontrol et ve ekleyebilirsen ekle, yoksa yeni ekle
        if let rightBarButtonItems = navigationItem.rightBarButtonItems {
            navigationItem.rightBarButtonItems = rightBarButtonItems + [item]
        } else {
            navigationItem.rightBarButtonItem = item
        }
    }
    
    func setLeftButton(clickAction: Selector, icon: String) {
        let item = UIBarButtonItem(
            image: UIImage(named: icon)?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: clickAction)
        
        // Sol bar button item'ı kontrol et ve ekleyebilirsen ekle, yoksa yeni ekle
        if let leftBarButtonItems = navigationItem.leftBarButtonItems {
            navigationItem.leftBarButtonItems = leftBarButtonItems + [item]
        } else {
            navigationItem.leftBarButtonItem = item
        }
    }
    
    func setRightCustomView(clickAction: Selector, view: UIView) {
        let item = UIBarButtonItem(customView: view)
        (view as? UIControl)?.addTarget(self, action: clickAction, for: .touchUpInside)
        
        // Sağ bar button item'ı kontrol et ve ekleyebilirsen ekle, yoksa yeni ekle
        if let rightBarButtonItems = navigationItem.rightBarButtonItems {
            navigationItem.rightBarButtonItems = rightBarButtonItems + [item]
        } else {
            navigationItem.rightBarButtonItem = item
        }
    }
}
