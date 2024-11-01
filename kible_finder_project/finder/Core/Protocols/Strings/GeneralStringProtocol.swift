//
//  GeneralStringProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import Foundation

protocol GeneralStringProtocol: BaseStringProtocol {
    var quickAccessTitle: String { get }
    var hadithDayTitle: String { get }
    var fridayMessageTitle: String { get }
    var verseDayTitle: String { get }
    var prayerDayTitle: String { get }
}

extension GeneralStringProtocol {
    var quickAccessTitle: String { return "Hızlı Erişim" }
    var hadithDayTitle: String { return "Günün Hadisi" }
    var fridayMessageTitle: String { return "Cuma Mesajları" }
    var verseDayTitle: String { return "Günün Ayeti" }
    var prayerDayTitle: String { return "Günün Duası" }
}
