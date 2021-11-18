//
//  NetworkingService.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation


struct NetworkService {
    
    
    private func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.apiUrl
        guard let url = urlString.asUrl else { return nil}
        var urlReq = URLRequest(url: url)
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlReq.url = urlComponent?.url
            case .post:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                urlReq.httpBody = bodyData
            }
        }
        
        return urlReq
    }
    
    private func request<T:Codable> (route: Route, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<T,Error>) -> Void) {
        
    }
    
    
    
}
