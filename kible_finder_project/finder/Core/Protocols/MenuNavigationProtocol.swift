//
//  MenuNavigationProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import Foundation

protocol MenuNavigationProtocol {
    func showMenu(menu: Menu, coordinator: MenuCommonCoordinatorProtocol?)
}

struct MenuNavigation: MenuNavigationProtocol {}

extension MenuNavigationProtocol {
    func showMenu(menu: Menu, coordinator: MenuCommonCoordinatorProtocol?) {
        switch menu {
        case .all:
            coordinator?.gotoAllMenu()
        case .prayerTime:
            coordinator?.gotoMenuVakitler()
        case .mosque:
            coordinator?.gotoMenuMosques()
        case .messages:
            coordinator?.gotoMenuMessages()
        case .hadith:
            coordinator?.gotoMenuHadiths()
        case .names:
            coordinator?.gotoMenuNames()
        case .calendar:
            coordinator?.gotoMenuCalendar()
        case .pray:
            coordinator?.gotoMenuPrayers()
        default:
            coordinator?.gotoAllMenu()
        }
    }
}
