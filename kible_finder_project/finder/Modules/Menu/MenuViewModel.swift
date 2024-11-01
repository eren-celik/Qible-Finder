//
//  MenuViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import Foundation

protocol MenuViewModelProtocol: MenuNavigationProtocol {
    var coordinator: MenuCoordinatorProtocol! { get set }
    var strings: SideMenuStringProtocol! { get set }
    var data: [Menu] { get set }
}

class MenuViewModel: MenuViewModelProtocol {
    var menuCoordinator: MenuCommonCoordinatorProtocol?
    var coordinator: MenuCoordinatorProtocol!
    var strings: SideMenuStringProtocol!
    lazy var data: [Menu] = Menu.sideMenu
}

protocol SideMenuStringProtocol: GeneralStringProtocol {
}

struct MenuStrings: SideMenuStringProtocol {
}
