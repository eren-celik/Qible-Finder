//
//  DateExtension.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 17.04.2023.
//

import Foundation

extension Date {
    
    public func toString(format: String = "MMMM dd yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "tr")
        return dateFormatter.string(from: self)
    }
    
    public func toHijriDateString(format: String = "dd MMMM yyyy") -> String? {
        var calendar = Calendar(identifier: .islamicCivil)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        if let date = calendar.date(from: components) {
            let hijriFormatter = DateFormatter()
            hijriFormatter.calendar = calendar
            hijriFormatter.locale = Locale(identifier: "tr")
            hijriFormatter.dateFormat = format
            return hijriFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    public func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current
        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)
        return abs(components.day ?? 0)
    }
    
    private func getLocalByID(_ identifier: String?) -> Locale {
        let local: Locale
        if let id = identifier, !id.isEmpty {
            local = Locale(identifier: id)
        } else {
            local = Locale.current
        }
        return local
    }
    
    public func localizedString(timezone: String?, dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .long) -> String {
        let dtFormater = DateFormatter()
        let tz: String = timezone ?? ""
        dtFormater.locale = getLocalByID(tz)
        dtFormater.dateStyle = dateStyle
        dtFormater.timeStyle = timeStyle
        if let timeZone = TimeZone(identifier: tz) {
            dtFormater.timeZone = timeZone
        }
        return dtFormater.string(from: self)
    }
    
    public func dateForTimezone(_ timezone: String?) -> Date {
        let nowUTC = Date()
        let tz: TimeZone
        if let timezone = timezone, let v = TimeZone(identifier: timezone) {
            tz = v
        } else {
            tz = TimeZone.current
        }
        let timeZoneOffset = Double(tz.secondsFromGMT(for: nowUTC))
        if let dt = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) {
            return dt
        } else {
            return Date()
        }
    }
    
    public func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    // Calculate the normalized progress between two times of day
    public func getCurrentTimeNormalized(from startTimeString: String, to endTimeString: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let startTime = dateFormatter.date(from: startTimeString),
              let endTime = dateFormatter.date(from: endTimeString) else {
            return nil
        }
        
        let calendar = Calendar.current
        
        // Calculate current time normalized progress
        let startOfDay = calendar.startOfDay(for: self)
        let startOfDayStartTime = calendar.date(bySettingHour: calendar.component(.hour, from: startTime), minute: calendar.component(.minute, from: startTime), second: 0, of: startOfDay)!
        var startOfDayEndTime = calendar.date(bySettingHour: calendar.component(.hour, from: endTime), minute: calendar.component(.minute, from: endTime), second: 0, of: startOfDay)!
        
        if startOfDayStartTime > startOfDayEndTime {
            startOfDayEndTime = calendar.date(byAdding: .day, value: 1, to: startOfDayEndTime)!
        }
        
        let elapsedSeconds = self.timeIntervalSince(startOfDayStartTime)
        let totalSecondsInRange = startOfDayEndTime.timeIntervalSince(startOfDayStartTime)
        
        // Normalize
        let normalizedValue = elapsedSeconds / totalSecondsInRange
        
        return normalizedValue
    }
}

// example
//let dt1 = Date()
//let tz = "Europe/Istanbul"
//let dt2 = dt1.description(with: .current)
//let dt3 = dt1.localizedString(timezone: tz)
//let dt4 = dt1.dateForTimezone(tz)
//print("Timezone: \(tz)\nDate: \(dt1)\ndescription: \(dt2)\nlocalized string: \(dt3)\ndateForTimezone: \(dt4)")
