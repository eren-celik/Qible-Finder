//
//  MessageViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import Foundation



protocol ListCommonBindingDelegate: BaseDisplayProtocol {
    func dataFetched()
}

protocol ListCommonViewModelProtocol {
    var endpoint: ListCommonEndpointProtocol! { get set }
    var coordinator: ListCommonCoordinatorProtocol! { get set }
    var delegate: ListCommonBindingDelegate! { get set }
    var strings: ListCommonStringProtocol! { get set }
    var dataMessage: [Message] { get set }
    var dataNames: [Names] { get set }
    var dataHadith: [Hadith] { get set }
    var tableData: [Any] { get set }
    var type: ListType { get set }
    var scheduledNotificationIds: [String] { get }
    
    init(endpoint: ListCommonEndpointProtocol)
    func serviceGet()
    func removeNotification(identifier: String)
    func notificationIsScheduled(for identifier: String?) -> Bool
}

class ListCommonViewModel: ListCommonViewModelProtocol {
    var endpoint: ListCommonEndpointProtocol!
    var coordinator: ListCommonCoordinatorProtocol!
    weak var delegate: ListCommonBindingDelegate!
    var strings: ListCommonStringProtocol!
    var dataMessage: [Message] = []
    var dataNames: [Names] = []
    var dataHadith: [Hadith] = []
    var dataCalendar: [IslamicCalendar] = []
    var tableData: [Any] = []
    var type: ListType = .message
    var scheduledNotificationIds: [String] = UserDefaultsManager.shared.notifications
    
    required init(endpoint: ListCommonEndpointProtocol = ListCommonEndpoint()) {
        self.endpoint = endpoint
    }
    
    func serviceGet() {
        switch type {
        case .names:
            fetchData { try await self.endpoint.names.retrieve() as [Names] }
        case .message:
            fetchData { try await self.endpoint.messages.retrieve() as [Message] }
        case .hadith:
            fetchData { try await self.endpoint.hadiths.retrieve() as [Hadith] }
        case .calendar:
            fetchData { try await self.endpoint.calendar.retrieve() as [IslamicCalendar] }
        }
    }
    
    func removeNotification(identifier: String) {
        UserDefaultsManager.shared.removeNotification(identifier)
        NotificationManager.shared.removePendingNotification(identifier: identifier)
        NotificationManager.shared.removeDeliveredNotification(identifier: identifier)
        debugPrint("removeNotification")
        debugPrint(identifier)
    }
    
    func notificationIsScheduled(for identifier: String?) -> Bool {
        guard let identifier else { return false }
        return scheduledNotificationIds.contains(where: {$0.self == identifier})
    }
    
    private func fetchData<T: Codable>(call: @escaping () async throws -> [T]) {
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                let data = try await call()
                await MainActor.run {
                    self.updateData(data)
                    self.delegate?.dataFetched()
                    self.delegate?.endLoading()
                }
            } catch let error {
                await MainActor.run {
                    self.delegate?.endLoading()
                    self.delegate?.display(error: error)
                }
            }
        }
    }
    
    private func updateData<T: Codable>(_ data: [T]) {
        switch type {
        case .names:
            dataNames = data as? [Names] ?? []
            tableData = dataNames
        case .message:
            dataMessage = data as? [Message] ?? []
            tableData = dataMessage
        case .hadith:
            dataHadith = data as? [Hadith] ?? []
            tableData = dataHadith
        case .calendar:
            dataCalendar = data as? [IslamicCalendar] ?? []
            tableData = dataCalendar
        }
    }
}

protocol ListCommonStringProtocol: GeneralStringProtocol {
    var dateReminderTitle: String { get }
    var confirmSelectionButton: String { get }
    var reminderTwoDayTitle: String { get }
    var reminderOneDayTitle: String { get }
}

struct ListCommonStrings: ListCommonStringProtocol {
    var dateReminderTitle: String { return "Tarih Hatırlatıcı" }
    var confirmSelectionButton: String { return "Seçimi Onayla" }
    var reminderTwoDayTitle: String { return "2 Gün Önce" }
    var reminderOneDayTitle: String { return "1 Gün Önce" }
}
