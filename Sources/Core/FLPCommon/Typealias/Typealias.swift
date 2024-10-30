//
//  Typealias.swift
//  FLCommon
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Foundation

public typealias VoidHandler = (() -> Void)
public typealias BoolHandler = ((Bool) -> Void)
public typealias BoolErrorHandler = ((Bool, Error?) -> Void)
public typealias OptionalBoolHandler = ((Bool?) -> Void)
public typealias StringHandler = ((String) -> Void)
public typealias OptionalStringHandler = ((String?) -> Void)
public typealias IntHandler = ((Int) -> Void)
public typealias OptionalIntHandler = ((Int?) -> Void)
public typealias FloatHandler = ((Float) -> Void)
public typealias OptionalFloatHandler = ((Float?) -> Void)
public typealias DoubleHandler = ((Double) -> Void)
public typealias OptionalDoubleHandler = ((Double?) -> Void)
public typealias DateHandler = ((Date) -> Void)
public typealias OptionalDateHandler = ((Date?) -> Void)

