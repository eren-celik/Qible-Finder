//
//  AlertPresentable.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 4.07.2024.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertController.Style)
    func showSettingsAlert(title: String, message: String)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSettingsAlert(title: String, message: String) {
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        showAlert(title: title, message: message, actions: [settingsAction, cancelAction])
    }
}
