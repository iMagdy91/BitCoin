//
//  HttpClient.swift
//  Bitcoin Converter
//
//  Created by Mohamed Hassanin on 20.03.19.
//  Copyright © 2019 Mohamed Hassanin. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveKit

class HttpClient: Client {
    
    //MARK: - Properties
    
    private let manager: Alamofire.SessionManager
    private let baseURL = URL(string: NetworkConstants.baseUrl)!
    
    //MARK: - Init
    
    init() {
        manager = Alamofire.SessionManager.default
    }
    
    //MARK: - Client protocol methods
    
    func request<Response>(_ endpoint: Webservice<Response>) -> Signal<Response, ResponseError> {
        return Signal<Response, ResponseError> { observer in
            let request = self.manager.request(self.url(path: endpoint.path),
                                               method: httpMethod(fromMethod: endpoint.method),
                                               parameters: endpoint.parameters,
                                               encoding: endpoint.encoding)
            
            request
                .validate()
                .responseData() { response in
                    let result = response.result.flatMap(endpoint.decode)
                    switch result {
                    case .success(let value):
                        observer.next(value)
                    case .failure(let error):
                        observer.failed(ResponseError(reason: error.localizedDescription,
                                                      statusCode: response.response?.statusCode ?? 0,
                                                      code: (error as NSError).code))
                    }
                    
            }
            return BlockDisposable {
                request.cancel()
            }

        }
    }
    
    //MARk: - Private Methods
    
    private func url(path: Path) -> URL {
        return baseURL.appendingPathComponent(path)
        
    }
}

//MARk: - Private Utils

private func httpMethod(fromMethod method: Method) -> Alamofire.HTTPMethod {
    switch method {
    case .get: return .get
    case .post: return .post
    }
}
