//
//  BaseErrorDisplayProtocol.swift
//  FLBase
//
//  Created by Ugur Cakmakci on 20.04.2023.
//

import Foundation

public protocol BaseErrorDisplayProtocol {
    func display(error: Error)
}

extension BaseErrorDisplayProtocol {
    public func display(error: Error) {
        debugPrint(error)
    }
}
