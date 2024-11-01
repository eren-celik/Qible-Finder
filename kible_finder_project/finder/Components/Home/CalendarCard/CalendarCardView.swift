//
//  CalendarCardView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 24.06.2024.
//

import UIKit

protocol CalendarCardViewModelProtocol {
    var data: [IslamicCalendar] { get set }
    var menuNavigation: MenuNavigationProtocol! { get set }
    var menuCoordinator: MenuCommonCoordinatorProtocol! { get set }
    var strings: GeneralStringProtocol! { get set }
}

struct CalendarCardViewModel: CalendarCardViewModelProtocol {
    var data: [IslamicCalendar] = []
    var menuNavigation: MenuNavigationProtocol!
    var menuCoordinator: MenuCommonCoordinatorProtocol!
    var strings: GeneralStringProtocol!
    
    init(menuNavigation: MenuNavigationProtocol!,
         menuCoordinator: MenuCommonCoordinatorProtocol!,
         strings: GeneralStringProtocol!) {
        self.menuNavigation = menuNavigation
        self.menuCoordinator = menuCoordinator
        self.strings = strings
    }
}

class CalendarCardView: BaseNibLoadableView {
    
    @IBOutlet weak var titleLabelView: TitleLabelView!
    @IBOutlet weak var tableView: TableView!
    
    var viewModel: CalendarCardViewModelProtocol!
    
    func configure(with viewModel: CalendarCardViewModelProtocol) {
        self.viewModel = viewModel
        titleLabelView.configure(
            with: TitleLabelViewModel(
                title: self.viewModel.strings.calendar,
                buttonTitle: self.viewModel.strings.all,
                buttonIsHidden: false,
                buttonHandler: allButtonHandler
            )
        )
        tableView.configure(delegate: self,
                            dataSource: self,
                            cell: CalendarCell.self)
    }
    
    func updateUI(data: [IslamicCalendar]) {
        viewModel.data = data
        tableView.reload()
    }
    
    func allButtonHandler() {
        viewModel.menuNavigation.showMenu(menu: .calendar, coordinator: viewModel.menuCoordinator)
    }
}

extension CalendarCardView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CalendarCardView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLastCell = indexPath.row == viewModel.data.count - 1
        let cell: CalendarCell = tableView.dequeueReusableCell(for: indexPath)
        cell.data = viewModel.data[indexPath.row]
        cell.isLastCell = isLastCell
        cell.bellContainerView.isHidden = true
        return cell
        
    }
}
