//
//  IntExtension.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

extension Int {
    
    public var toString: String {
        String(self)
    }
     
    public var toDouble: Double {
        Double(self)
    }
    
    public var toHex: String {
        String(self, radix: 16)
    }
    
    public var digitCount: Int {
        numberOfDigits(in: self)
    }
    
    // private recursive method for counting digits
    private func numberOfDigits(in number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number/10)
        }
    }
}
