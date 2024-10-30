//
//  ListCommonDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 23.06.2024.
//

import Foundation


enum ListType {
    case names
    case message
    case hadith
    case calendar
    
    func title(using strings: GeneralStringProtocol) -> String {
        switch self {
        case .names:
            return strings.names
        case .message:
            return strings.messages
        case .hadith:
            return strings.hadith
        case .calendar:
            return strings.calendar
        }
    }
}
