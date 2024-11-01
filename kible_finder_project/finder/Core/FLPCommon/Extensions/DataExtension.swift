//
//  DataExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

extension Data {
    
    public var toDictionary: [String: Any]? {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: self, options: []),
              let convertedDict = jsonDict as? [String: Any] else { return nil }
        return convertedDict
    }
    
    public var toString: String {
        String(decoding: self, as: UTF8.self)
    }
    
    public var toHex: String {
        return map { String(format: "%02x", $0) }.joined()
    }
}
