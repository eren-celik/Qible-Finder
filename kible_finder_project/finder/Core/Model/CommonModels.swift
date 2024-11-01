//
//  CommonModels.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 21.06.2024.
//

import Foundation

protocol CardViewProtocol {
    var id: String? { get set }
    var content: String? { get set }
    var imageUrl: String? { get set }
}

struct Hadith: BaseModelProtocol {
    var id: String?
    var content: String?
    var imageUrl: String?
    var date: String?
    var referance: String?
}

struct Prayer: BaseModelProtocol, CardViewProtocol {
    var id: String?
    var content: String?
    var imageUrl: String?
    var title: String?
    var contentLatin: String?
    var contentArabic: String?
}

struct Message: BaseModelProtocol, CardViewProtocol {
    var id: String?
    var content: String?
    var imageUrl: String?
}

struct Verse: BaseModelProtocol, CardViewProtocol {
    var id: String?
    var content: String?
    var imageUrl: String?
    var referance: String?
}

struct Names: BaseModelProtocol {
    var id: String?
    var name: String?
    var desc: String?
    var arabic: String?
}

struct IslamicCalendar: BaseModelProtocol {
    var id: String?
    var day: String?
    var date: String?
}

struct PrayerTime: BaseModelProtocol {
    var date: String?
    var hijri_date: String?
    var times: Time?
    
    struct Time: BaseModelProtocol {
        var asr: String?
        var fajr: String?
        var isha: String?
        var dhuhr: String?
        var maghrib: String?
        var sunrise: String?
    }
}
