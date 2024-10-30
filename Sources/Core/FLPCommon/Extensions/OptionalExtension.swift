//
//  OptionalExtension.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmtpy: Bool {
        self?.isEmpty ?? true
    }
}

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
    
    var valueOrEmpty: Wrapped {
        guard let unwrapped = self else {
            return [] as! Wrapped
        }
        return unwrapped
    }
}
