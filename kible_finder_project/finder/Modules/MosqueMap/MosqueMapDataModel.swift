//
//  MosqueMapDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import Foundation

struct MosqueMap: BaseModelProtocol {
    var id: String?
    var lat: Float?
    var long: Float?
    var imageUrl: String?
    var name: String?
    var address: String?
}
    
