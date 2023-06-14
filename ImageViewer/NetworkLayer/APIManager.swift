//
//  APIManager.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import Foundation

enum APIManager {
    case getRandomListImages
    case searchPhoto(name: String)
    
    typealias HTTPHeaders = [String: String]
    
    var baseUrl: String {
        return "https://api.unsplash.com/"
    }
    
    private var path: String {
        switch self {
        case .getRandomListImages:
            return "/photos/random"
        case .searchPhoto(_):
            return "/search/photos"
        }
    }
    
    private var headers: HTTPHeaders {
        return ["Authorization": "Client-ID 8yUIV_AY-pm8rFPNNVsYsrOYxMlkfRAmvwKdUqJzMV0"]
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getRandomListImages:
            return [URLQueryItem(name: "count",
                                 value: "30"),
                    URLQueryItem(name: "orientation",
                                 value: "landscape")]
            
        case .searchPhoto(name: let name):
            return [URLQueryItem(name: "query",
                                 value: name),
                    URLQueryItem(name: "orientation",
                                 value: "landscape")]
        }
    }
    
    private var url: URL? {
        var components = URLComponents(string: baseUrl)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
    
    func request() -> URLRequest? {
        guard let url = url else { return nil }
        print(url)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        return request
    }
    
}
