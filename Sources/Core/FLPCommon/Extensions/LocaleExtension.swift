//
//  LocaleExtension.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 17.04.2023.
//

import Foundation

public extension Locale {
    
    var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = self
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
}
