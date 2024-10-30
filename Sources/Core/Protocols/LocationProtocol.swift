//
//  LocationProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.07.2024.
//

import Foundation
import CoreLocation


protocol CoreLocationProtocol {
    func requestLocationWithAuthorization(authorizationCompletion: VoidHandler?, deniedCompletion: VoidHandler?, notDeterminedCompletion: VoidHandler?, locationUpdate: UpdateLocationHandler?)
    func requestAuthorization(authorizationCompletion: VoidHandler?, deniedCompletion: VoidHandler?, notDeterminedCompletion: VoidHandler?)
    func requestLocation(locationUpdate: UpdateLocationHandler?)
}

extension CoreLocationProtocol {
    func requestLocationWithAuthorization(authorizationCompletion: VoidHandler? = nil,
                                          deniedCompletion: VoidHandler? = nil,
                                          notDeterminedCompletion: VoidHandler? = nil,
                                          locationUpdate: UpdateLocationHandler? = nil) {
        if LocationManager.shared.hasAuthorization {
            requestLocation(locationUpdate: locationUpdate)
        } else {
            requestAuthorization(authorizationCompletion: authorizationCompletion, deniedCompletion: deniedCompletion, notDeterminedCompletion: notDeterminedCompletion)
        }
    }
    
    func requestAuthorization(authorizationCompletion: VoidHandler? = nil, deniedCompletion: VoidHandler? = nil, notDeterminedCompletion: VoidHandler? = nil) {
        LocationManager.shared.requestAuthorization(completion: authorizationCompletion,
                                                    deniedCompletion: deniedCompletion,
                                                    notDeterminedCompletion: notDeterminedCompletion)
    }
    
    func requestLocation(locationUpdate: UpdateLocationHandler?) {
        LocationManager.shared.requestLocationUpdate(handler: locationUpdate)
    }
    
}
