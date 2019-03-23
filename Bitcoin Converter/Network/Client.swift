//
//  Client.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveKit

protocol Client {
    func request<Response>(_ endpoint: Webservice<Response>) -> Signal<Response, ResponseError>
}
