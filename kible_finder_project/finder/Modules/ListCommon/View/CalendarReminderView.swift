//
//  CalendarReminderView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 24.06.2024.
//

import UIKit


typealias IslamicCalendarHandler = ((IslamicCalendar?) -> Void)

protocol CalendarReminderViewModelProtocol {
    var data: IslamicCalendar { get }
    var strings: ListCommonStringProtocol { get }
    var reminderDay: CalendarReminderViewModel.ReminderDay? { get set }
    var notificationPermissionDeniedHandler: VoidHandler? { get set }
    var notificationScheduledHandler: IslamicCalendarHandler? { get set }
    
    init(data: IslamicCalendar, strings: ListCommonStringProtocol, notificationPermissionDeniedHandler: VoidHandler?, notificationScheduledHandler: IslamicCalendarHandler?)
    
    func checkAndScheduleNotification()
}


struct CalendarReminderViewModel: CalendarReminderViewModelProtocol {
    var data: IslamicCalendar
    var strings: ListCommonStringProtocol
    var reminderDay: ReminderDay?
    var notificationPermissionDeniedHandler: VoidHandler?
    var notificationScheduledHandler: IslamicCalendarHandler?
    
    init(data: IslamicCalendar, strings: ListCommonStringProtocol, notificationPermissionDeniedHandler: VoidHandler? = nil, notificationScheduledHandler: IslamicCalendarHandler? = nil) {
        self.data = data
        self.strings = strings
        self.notificationPermissionDeniedHandler = notificationPermissionDeniedHandler
        self.notificationScheduledHandler = notificationScheduledHandler
    }
    
    func checkAndScheduleNotification() {
        // SAAT ONEMLI MI? HANGI SAATA KURMAMIZ GEREK
        guard let reminderDay, let stringDate = data.date else { return }
        Task {
            let date = stringDate.toDate(format: DateType.yyyyMMdd.rawValue)
            let (success, error) = await NotificationManager.shared.checkAndScheduleNotification(
                title: data.day ?? "",
                body: "This is your reminder notification",
                identifier: data.id ?? "",
                date: date.add(days: -reminderDay.time)
            )
            
            if success {
                notificationScheduledHandler?(self.data)
            } else if let error = error {
                debugPrint("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                notificationPermissionDeniedHandler?()
            }
        }
    }
    
    enum ReminderDay {
        case one
        case two
        
        var time: Int {
            switch self {
            case .one:
                1
            case .two:
                2
            }
        }
    }
}

class CalendarReminderView: BaseNibLoadableView {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var twoDayOptionView: OptionButtonView!
    @IBOutlet weak var oneDayOptionView: OptionButtonView!
    @IBOutlet weak var confirmButton: Button!
    
    var viewModel: CalendarReminderViewModelProtocol!
    
    func configure(with viewModel: CalendarReminderViewModelProtocol) {
        self.viewModel = viewModel
        
        titleLabel.configure(with: .init(text: self.viewModel.strings.dateReminderTitle,
                                         font: .xsBold,
                                         textColor: .blackBase,
                                         alignment: .center))
        
        twoDayOptionView.configure(with: OptionButtonViewModel(title: self.viewModel.strings.reminderTwoDayTitle,
                                                               checkboxHandler: twoDayOptionHandler))
        oneDayOptionView.configure(with: OptionButtonViewModel(title: self.viewModel.strings.reminderOneDayTitle,
                                                               checkboxHandler: oneDayOptionHandler))
        confirmButton.configure(
            with: .init(
                style: .disable,
                title: self.viewModel.strings.confirmSelectionButton,
                alignment: .center,
                action: onConfirmSelectionButtonTapped)
        )
        
        
    }
    
    func twoDayOptionHandler() {
        confirmButton.updateStyle(.blue)
        viewModel.reminderDay = .two
        twoDayOptionView.isSelected = true
        oneDayOptionView.isSelected = false
    }
    
    func oneDayOptionHandler() {
        confirmButton.updateStyle(.blue)
        viewModel.reminderDay = .one
        twoDayOptionView.isSelected = false
        oneDayOptionView.isSelected = true
    }
    
    @objc
    func onConfirmSelectionButtonTapped() {
        viewModel.checkAndScheduleNotification()
    }
}


