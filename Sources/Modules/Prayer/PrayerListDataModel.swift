//
//  PrayerListDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import Foundation

struct PrayerSection {
    var title: String
    var desc: String
    var items: [Prayer]
    var isExpanded: Bool
}

struct PrayerData: BaseModelProtocol {
    var id: String?
    var title: String?
    var desc: String?
    var prayers: [Prayer]?
}
