//
//  ResponseError.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation


class ResponseError: Error {
    
    //MARK: - Properties
    
    var reason: String
    var statusCode: Int
    var errorType: URLError.Code
    
    //MARK: - Init
    
    init(reason: String, statusCode: Int, code: Int) {
        self.reason = reason
        self.statusCode = statusCode
        self.errorType = URLError.Code(rawValue: code)
    
    }

}
