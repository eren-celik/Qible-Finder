//
//  BaseModelProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 21.06.2024.
//

import Foundation


public protocol BaseModelProtocol: Codable, CustomStringConvertible {}

extension BaseModelProtocol {
    public var description: String {
        self.toJsonString ?? ""
    }
}
