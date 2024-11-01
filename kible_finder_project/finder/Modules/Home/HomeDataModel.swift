//
//  HomeDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import Foundation

struct HomeResponseData: BaseModelProtocol {
    let data: Home?
}

struct Home: BaseModelProtocol {
    let id: String?
    let dayVerse: Verse?
    let dayHadith: [Hadith]?
    let dayPrayer: Prayer?
    let calendar: [IslamicCalendar]?
    let dayMessage: Message?
}
