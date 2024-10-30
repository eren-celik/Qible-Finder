//
//  NamazService.swift
//  Namaz
//
//  Created by Serkan Kayaduman on 26.10.2024.
//

import UIKit

public class NamazService {
    public static let shared = NamazService()
    
    internal var windowCloseHandler: (()->Void)?
    private var namazWindow: UIWindow!
    
    public init() {
        
    }
    
    public func showNamazUI(forWindowScene windowScene: UIWindowScene, closeHandler: (()->Void)? = nil) {
        self.windowCloseHandler = closeHandler
        
        self.namazWindow = UIWindow(windowScene: windowScene)
        self.namazWindow.windowLevel = UIWindow.Level.statusBar + 1
        
        let coordinator = TabBarCoordinator(window: self.namazWindow)
        coordinator.start()
    }
    
    public func closeNamazUI() {
        self.namazWindow.isHidden = true
        self.namazWindow.removeFromSuperview()
        self.namazWindow = nil
        
        self.windowCloseHandler?()
    }
}
