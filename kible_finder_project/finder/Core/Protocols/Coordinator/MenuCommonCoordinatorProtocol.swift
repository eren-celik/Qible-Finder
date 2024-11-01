//
//  MenuProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//



protocol MenuCommonCoordinatorProtocol {
    func gotoAllMenu()
    func gotoMenuVakitler()
    func gotoMenuMessages()
    func gotoMenuHadiths()
    func gotoMenuNames()
    func gotoMenuCalendar()
    func gotoMenuPrayers()
    func gotoMenuMosques()
}
extension MenuCommonCoordinatorProtocol where Self: MenuCommonCoordinatorProtocol & BaseCoordinator {
    func gotoAllMenu() {
        self.tabBarController?.selectedIndex = 2
    }
    
    func gotoMenuVakitler() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func gotoMenuMessages() {
        let coordinator = ListCommonCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.push(with: .message, cell: MessageCell.self)
    }
    
    func gotoMenuHadiths() {
        let coordinator = ListCommonCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.push(with: .hadith, cell: HadithCell.self)
    }
    
    func gotoMenuNames() {
        let coordinator = ListCommonCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.push(with: .names, cell: NamesCell.self)
    }
    
    func gotoMenuCalendar() {
        let coordinator = ListCommonCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.push(with: .calendar, cell: CalendarCell.self)
    }
    
    func gotoMenuPrayers() {
        let coordinator = PrayerListCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.start()
    } 
    
    func gotoMenuMosques() {
        let coordinator = MosqueMapCoordinator(with: self.navigationController, tabBarController: self.tabBarController)
        coordinator.start()
    }
}
