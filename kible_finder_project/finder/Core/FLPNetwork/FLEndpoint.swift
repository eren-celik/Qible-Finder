//
//  Endpoint.swift
//  FLNetwork
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import Alamofire
import Foundation

public enum FLParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlEncodingBody
}

public protocol Retrieve {
    func retrieve<T: Decodable>() async throws -> T
}


open class FLEndpoint: Retrieve {
    open var host: String = ""
    open var path: String
    open var encoding: FLParameterEncoding
    open var parameters: Parameters?
    open var body: String?
    open var method: HTTPMethod
    open var headers: HTTPHeaders
    
    public init(path: String = "",
                encoding: FLParameterEncoding = .jsonEncoding,
                parameters: Parameters? = nil,
                body: String? = nil,
                method: HTTPMethod = .get,
                headers: HTTPHeaders = .default) {
        self.path = path
        self.encoding = encoding
        self.parameters = parameters
        self.body = body
        self.method = method
        self.headers = headers
    }
}

extension FLEndpoint {
    var relativeURLString: String {
        return String(format: "%@%@", host, path)
    }
    
    var convertedEncoding: ParameterEncoding {
        switch encoding {
        case .urlEncoding:
            return URLEncoding.queryString
        case .jsonEncoding:
            return JSONEncoding.default
        case .urlEncodingBody:
            return URLEncoding.httpBody
        }
    }
    
    public func retrieve<T: Decodable>() async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(self.relativeURLString,
                       method: self.method,
                       parameters: self.parameters,
                       encoding: self.convertedEncoding,
                       headers: self.headers)
            .validate()
            .responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
