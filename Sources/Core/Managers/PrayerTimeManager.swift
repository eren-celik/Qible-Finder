//
//  PrayerTimeManager.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 17.07.2024.
//

import Foundation

protocol PrayerTimeManagerDelegate {
    func didUpdateTimeUntilNextPrayer(_ timeString: String)
    func countDownIsOver()
}

class PrayerTimeManager {
    static let shared = PrayerTimeManager()
    
    private var prayerTimes: [PrayerTime] = []
    private let dateFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    private let dateTimeFormatter: DateFormatter
    private var timer: Timer?
    
//    let nextPrayerTimeDate = Date().add(seconds: 5)
    var delegate: PrayerTimeManagerDelegate?
    
    var nextPrayerTime: TimeType? {
        switch currentPrayerTime {
        case .fajr:
            return .sunrise
        case .sunrise:
            return .dhuhr
        case .dhuhr:
            return .asr
        case .asr:
            return .maghrib
        case .maghrib:
            return .isha
        case .isha:
            return nil
        case .none:
            return nil
        }
    }
    
    var currentPrayerTime: TimeType? {
        let date = Date()
        guard let times = prayerTimes.first?.times else {
            return nil
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let fajrTime = combine(dateComponents: components, with: times.fajr ?? ""),
              let sunriseTime = combine(dateComponents: components, with: times.sunrise ?? ""),
              let dhuhrTime = combine(dateComponents: components, with: times.dhuhr ?? ""),
              let asrTime = combine(dateComponents: components, with: times.asr ?? ""),
              let maghribTime = combine(dateComponents: components, with: times.maghrib ?? ""),
              let ishaTime = combine(dateComponents: components, with: times.isha ?? "") else {
            return nil
        }
        
        if date >= fajrTime && date < sunriseTime {
            return .fajr
        } else if date >= sunriseTime && date < dhuhrTime {
            return .sunrise
        } else if date >= dhuhrTime && date < asrTime {
            return .dhuhr
        } else if date >= asrTime && date < maghribTime {
            return .asr
        } else if date >= maghribTime && date < ishaTime {
            return .maghrib
        } else if date >= ishaTime || date < fajrTime {
            return .isha
        }
        
        return nil
    }
    
    private init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd MMMM yyyy EEEE"
        
        self.timeFormatter = DateFormatter()
        self.timeFormatter.dateFormat = "HH:mm"
        
        self.dateTimeFormatter = DateFormatter()
        self.dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        startTimer()
    }
    
    func setPrayerTimes(_ prayerTimes: [PrayerTime]) {
        self.prayerTimes = prayerTimes
    }
    
    private func combine(dateComponents: DateComponents, with timeString: String) -> Date? {
        var components = dateComponents
        let timeComponents = timeString.split(separator: ":").map { Int($0) }
        if timeComponents.count == 2 {
            components.hour = timeComponents[0]
            components.minute = timeComponents[1]
            return Calendar.current.date(from: components)
        }
        return nil
    }
    
    func timeUntilNextPrayer() -> String? {
        guard let nextPrayer = nextPrayerTime else {
            return nil
        }
        
        let date = Date()
        guard let times = prayerTimes.first?.times else {
            return nil
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let nextPrayerTimeDate = getTime(for: nextPrayer, from: times, with: components) else {
            return nil
        }
        
        let timeInterval = nextPrayerTimeDate.timeIntervalSince(date)
        if timeInterval <= 1 {
            return nil
        }
        
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        
        let formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return formattedTime
    }
    
    private func getTime(for prayer: TimeType, from times: PrayerTime.Time, with components: DateComponents) -> Date? {
        switch prayer {
        case .fajr:
            return combine(dateComponents: components, with: times.fajr ?? "")
        case .sunrise:
            return combine(dateComponents: components, with: times.sunrise ?? "")
        case .dhuhr:
            return combine(dateComponents: components, with: times.dhuhr ?? "")
        case .asr:
            return combine(dateComponents: components, with: times.asr ?? "")
        case .maghrib:
            return combine(dateComponents: components, with: times.maghrib ?? "")
        case .isha:
            return combine(dateComponents: components, with: times.isha ?? "")
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeUntilNextPrayer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimeUntilNextPrayer() {
        guard let timeString = timeUntilNextPrayer() else {
            delegate?.countDownIsOver()
            return
        }
        delegate?.didUpdateTimeUntilNextPrayer(timeString)
    }
}

extension PrayerTimeManager {
    enum TimeType {
        case fajr
        case sunrise
        case dhuhr
        case asr
        case maghrib
        case isha
        
        var title: String {
            switch self {
            case .fajr:
                return "İmsak"
            case .sunrise:
                return "Güneş"
            case .dhuhr:
                return "Öğle"
            case .asr:
                return "İkindi"
            case .maghrib:
                return "Akşam"
            case .isha:
                return "Yatsı"
            }
        }
        
        var icon: String {
            switch self {
            case .fajr:
                return "icon_imsak_standart"
            case .sunrise:
                return "icon_gunes_ogle_standart"
            case .dhuhr:
                return "icon_gunes_ogle_standart"
            case .asr:
                return "icon_ikindi_standart"
            case .maghrib:
                return "icon_aksam_standart"
            case .isha:
                return "icon_yatsi_standart"
            }
        }
        
        var filledIcon: String {
            switch self {
            case .fajr:
                return "icon_imsak_standart_fill"
            case .sunrise:
                return "icon_gunes_ogle_standart_fill"
            case .dhuhr:
                return "icon_gunes_ogle_standart_fill"
            case .asr:
                return "icon_ikindi_standart_fill"
            case .maghrib:
                return "icon_aksam_standart_fill"
            case .isha:
                return "icon_yatsi_standart_fill"
            }
        }
    }
}
