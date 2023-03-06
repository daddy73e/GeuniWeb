//
//  APIProtocol.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/06.
//

import Foundation

public protocol APIProtocol {
    associatedtype Request: APIRequest
    associatedtype Response: APIResponse
}

public protocol APIRequest: Encodable {
    associatedtype Header: Encodable
    associatedtype Body: Encodable

    var dataHeader: Header { get }
    var dataBody: Body { get }
}

public protocol APIResponse: Decodable {
    associatedtype Header: Decodable
    associatedtype Body: Decodable

    var dataHeader: Header { get }
    var dataBody: Body { get }
}
