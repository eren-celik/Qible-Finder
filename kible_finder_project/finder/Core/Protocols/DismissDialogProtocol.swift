//
//  DismissDialogProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 25.06.2024.
//

import Foundation

protocol DismissDialogProtocol {
    func dismissDialog()
}

extension DismissDialogProtocol where Self: BaseViewController {
    func dismissDialog() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
