//
//  NotificationManager.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 25.06.2024.
//

import Foundation
import UserNotifications


final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    // MARK: - Authorization
    
    func requestAuthorization() async -> (Bool, Error?) {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                continuation.resume(returning: (granted, error))
            }
        }
    }
    
    func checkNotificationAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    continuation.resume(returning: true)
                case .notDetermined:
                    Task {
                        let (granted, _) = await self.requestAuthorization()
                        continuation.resume(returning: granted)
                    }
                case .denied, .provisional, .ephemeral:
                    continuation.resume(returning: false)
                @unknown default:
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    // MARK: - Notification Management
    
    func createNotificationContent(title: String, body: String, sound: UNNotificationSound = .default, badge: NSNumber? = nil) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound
        content.badge = badge
        return content
    }
    
    func scheduleNotification(for title: String, body: String, identifier: String, date: Date) async -> (Bool, Error?) {
        let content = createNotificationContent(title: title, body: body)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        return await scheduleNotification(identifier: identifier, content: content, trigger: trigger)
    }
    
    private func scheduleNotification(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger) async -> (Bool, Error?) {
        await withCheckedContinuation { continuation in
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    debugPrint("Bildirim zamanlama hatası: \(error.localizedDescription)")
                    continuation.resume(returning: (false, error))
                } else {
                    debugPrint("Bildirim zamanlandı")
                    debugPrint(identifier)
                    continuation.resume(returning: (true, nil))
                }
            }
        }
    }
    
    func checkAndScheduleNotification(title: String, body: String, identifier: String, date: Date) async -> (Bool, Error?) {
        let granted = await checkNotificationAuthorization()
        
        if granted {
            return await scheduleNotification(for: title, body: body, identifier: identifier, date: date)
        } else {
            return (false, nil) // Permission not granted
        }
    }
    
    // MARK: - Removing Notifications
    
    func removePendingNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func removeDeliveredNotification(identifier: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
    }
}
