//
//  MenuDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit

enum Menu: CaseIterable {
    case all
    case prayerTime
    case qible
    case mosque
    case pray
    case quran
    case calendar
    case names
    case dhikr
    case hadith
    case messages
    
    static var allMenu: [Menu] = Menu.allCases
    static var sideMenu: [Menu] = Array(Menu.allCases.dropFirst())
    
    func title(using strings: GeneralStringProtocol) -> String {
        switch self {
        case .all:
            strings.all
        case .prayerTime:
            strings.prayerTime
        case .qible:
            strings.qible
        case .mosque:
            strings.mosque
        case .pray:
            strings.pray
        case .quran:
            strings.quran
        case .calendar:
            strings.calendar
        case .names:
            strings.names
        case .dhikr:
            strings.dhikr
        case .hadith:
            strings.hadith
        case .messages:
            strings.messages
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .all:
            UIImage.namazAsset(named: "icon_menu_all")
        case .prayerTime:
            UIImage.namazAsset(named: "icon_menu_namaz")
        case .qible:
            UIImage.namazAsset(named: "icon_menu_compass")
        case .mosque:
            UIImage.namazAsset(named: "icon_menu_mosque")
        case .pray:
            UIImage.namazAsset(named: "icon_menu_pray")
        case .quran:
            UIImage.namazAsset(named: "icon_menu_quran")
        case .calendar:
            UIImage.namazAsset(named: "icon_menu_calendar")
        case .names:
            UIImage.namazAsset(named: "icon_menu_names")
        case .dhikr:
            UIImage.namazAsset(named: "icon_menu_zikir")
        case .hadith:
            UIImage.namazAsset(named: "icon_menu_hadis")
        case .messages:
            UIImage.namazAsset(named: "icon_menu_messages")
        }
    }
}
