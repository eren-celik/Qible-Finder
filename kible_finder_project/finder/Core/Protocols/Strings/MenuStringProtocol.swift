//
//  MenuStringProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import Foundation

public protocol MenuStringProtocol {
    var prayerTime: String { get }
    var qible: String { get }
    var mosque: String { get }
    var pray: String { get }
    var quran: String { get }
    var calendar: String { get }
    var names: String { get }
    var dhikr: String { get }
    var hadith: String { get }
    var messages: String { get }
}

public extension MenuStringProtocol where Self: MenuStringProtocol {
    var prayerTime: String { "Namaz Vakitleri" }
    var qible: String { "Kıble Bulucu" }
    var mosque: String { "Ek Yakın Camiler" }
    var pray: String { "Dualar" }
    var quran: String { "Kur’an-ı Kerim" }
    var calendar: String { "Dini Takvim" }
    var names: String { "Allah’ın 99 İsmi" }
    var dhikr: String { "Zikir" }
    var hadith: String { "Hadisler" }
    var messages: String { "Cuma Mesajları" }
}
