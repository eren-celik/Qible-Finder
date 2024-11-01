//
//  Endpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import Alamofire

open class Endpoint: FLEndpoint {
    var apiHost: String { "https://api.json-generator.com/templates/" }
    var apiHeaders: HTTPHeaders = .init(["Authorization": "Bearer 7p3eske6oxga7zko1zb204a6m2xfnu4cmrz9nde4"])
    
    public init(host: String? = nil,
                path: String = "",
                encoding: FLParameterEncoding = .jsonEncoding,
                parameters: Parameters? = nil,
                body: String? = nil,
                method: HTTPMethod = .get,
                headers: HTTPHeaders? = nil) {
        super.init(path: path, encoding: encoding, parameters: parameters, body: body, method: method, headers: headers ?? apiHeaders)
        self.host = host ?? apiHost
        self.headers = headers ?? apiHeaders
    }
}
