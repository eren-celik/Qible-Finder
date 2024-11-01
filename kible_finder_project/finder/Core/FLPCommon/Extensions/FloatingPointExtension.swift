//
//  FloatingPointExtension.swift
//  FLCommon
//
//  Created by Burak on 12.10.2023.
//

import Foundation

extension FloatingPoint {
    public var whole: Self { modf(self).0 }
    public var fraction: Self { modf(self).1 }
}
