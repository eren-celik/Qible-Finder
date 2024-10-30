//
//  LocationStringProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import Foundation

public protocol LocationStringProtocol {
    var deniedAuthRequestMessage: String { get }
}

public extension LocationStringProtocol where Self: LocationStringProtocol {
    var authRequestMessage: String { return "Uygulamayı kullanabilmeniz için konum paylaşımına izin vermeniz gerekmektedir" }
    var deniedAuthRequestMessage: String { return "Konum iznini telefonunuzun ayarlar bölümünden verebilirsiniz" }
}
