//
//  VakitlerViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import Foundation

protocol VakitlerBindingDelegate: BaseDisplayProtocol {}

protocol VakitlerViewModelProtocol {
    var endpoint: VakitlerEndpointProtocol! { get set }
    var coordinator: VakitlerCoordinatorProtocol! { get set }
    var delegate: VakitlerBindingDelegate! { get set }
    init(endpoint: VakitlerEndpointProtocol)
    
}

class VakitlerViewModel: VakitlerViewModelProtocol {
    var endpoint: VakitlerEndpointProtocol!
    var coordinator: VakitlerCoordinatorProtocol!
    weak var delegate: VakitlerBindingDelegate!
    
    required init(endpoint: VakitlerEndpointProtocol = VakitlerEndpoint()) {
        self.endpoint = endpoint
    }
}

extension VakitlerViewModel {
    
}
