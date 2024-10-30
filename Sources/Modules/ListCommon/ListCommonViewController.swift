//
//  MessageViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import UIKit

import PanModal

class ListCommonViewController: BaseViewController {
    var viewModel: ListCommonViewModelProtocol!
    
    @IBOutlet weak var tableView: TableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUI<T: FLTableViewCell>(cell: T.Type) {
        setLeftTitle(viewModel.type.title(using: viewModel.strings))
        configureTableView(with: cell)
        viewModel.serviceGet()
    }
    
    private func configureTableView<T: FLTableViewCell>(with cellType: T.Type) {
        tableView.configure(delegate: self, dataSource: self)
        tableView.registerCell(cellType.self)
    }
    
    func showReminderView(_ data: IslamicCalendar?) {
        guard let data = data else { return }
        let calendarReminderView = CalendarReminderView()
        calendarReminderView.configure(with: CalendarReminderViewModel(data: data,
                                                                       strings: viewModel.strings,
                                                                       notificationPermissionDeniedHandler: notificationPermissionDeniedHandler,
                                                                       notificationScheduledHandler: notificationScheduledHandler))
        let panModalViewController = PanModalViewController(contentView: calendarReminderView)
        presentPanModal(panModalViewController)
    }
    
    func updateCellNotificationState(for data: IslamicCalendar?, scheduled: Bool) {
        guard let data,
              let index = viewModel.tableData.firstIndex(where: { ($0 as? IslamicCalendar)?.id == data.id })
        else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        DispatchQueue.main.async { [weak self] in
            let cell = self?.tableView.table.cellForRow(at: indexPath) as? CalendarCell
            cell?.bellButton.isSelected = scheduled
        }
    }
    
    func notificationPermissionDeniedHandler() {
        dismissDialog()
        let alert = UIAlertController(title: "Bildirim İzni Gerekli", message: "Bildirimleri etkinleştirmek için lütfen ayarlardan bildirim izni verin.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func notificationScheduledHandler(data: IslamicCalendar?) {
        guard let id = data?.id else { return }
        dismissDialog()
        UserDefaultsManager.shared.addNotification(id)
        updateCellNotificationState(for: data, scheduled: true)
    }
    
    func scheduleNotificationHandler(data: IslamicCalendar?, schedule: Bool) {
        guard let data = data else { return }
        if schedule {
            showReminderView(data)
        } else {
            updateCellNotificationState(for: data, scheduled: false)
            viewModel.removeNotification(identifier: data.id ?? "")
        }
    }
}

// MARK: - ListCommonBindingDelegate
extension ListCommonViewController: ListCommonBindingDelegate {
    func dataFetched() {
        tableView.reload()
    }
}

// MARK: - UITableViewDelegate
extension ListCommonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Implement cell selection handling if needed
    }
}

// MARK: - UITableViewDataSource
extension ListCommonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLastCell = indexPath.row == viewModel.tableData.count - 1
        let cellData = viewModel.tableData[indexPath.row]
        
        switch viewModel.type {
        case .message:
            let cell: MessageCell = tableView.dequeueReusableCell(for: indexPath)
            cell.data = cellData as? Message
            return cell
        case .hadith:
            let cell: HadithCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setUI(with: cellData as? Hadith, strings: viewModel.strings)
            return cell
        case .names:
            let cell: NamesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.data = cellData as? Names
            return cell
        case .calendar:
            let cell: CalendarCell = tableView.dequeueReusableCell(for: indexPath)
            let data = cellData as? IslamicCalendar
            cell.data = data
            cell.isNotificationActive = viewModel.notificationIsScheduled(for: data?.id)
            cell.isLastCell = isLastCell
            cell.scheduleNotificationHandler = scheduleNotificationHandler
            return cell
        }
    }
}
