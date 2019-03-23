//
//  Webservice.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

//MARK: - Define

typealias Parameters = [String: Any]
typealias Path = String

enum Method {
    case get, post
}

//MARK: - Webservice class

final class Webservice<Response> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let decode: (Data) throws -> Response
    
    init(method: Method = .get,
         path: Path,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = JSONEncoding.default,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.encoding = encoding
        self.decode = decode
    }
}

//MARK: - Webservice extension

extension Webservice where Response: EVObject {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = JSONEncoding.default) {
        self.init(method: method, path: path, parameters: parameters, encoding: encoding) {
            Response(data: $0)
        }
    }
}
