//
//  ButtonStringProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import Foundation

public protocol ButtonStringProtocol {
    var yes: String { get }
    var no: String { get }
    var ok: String { get }
    var cancel: String { get }
    var share: String { get }
    var all: String { get }
    var delete: String { get }
}

public extension ButtonStringProtocol where Self: ButtonStringProtocol {
    var yes: String { "Evet" }
    var no: String { "Hayır" }
    var ok: String { "Tamam" }
    var cancel: String { "İptal" }
    var share: String { "Paylaş" }
    var all: String { "Tümü" }
    var delete: String { "Sil" }
}
