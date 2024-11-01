//
//  ArrayExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

extension Array where Element: Equatable {
    
    public func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
    
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
