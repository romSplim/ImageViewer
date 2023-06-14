//
//  NetworkError.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case cannotDecode
    
    var message: String {
        switch self {
        default:
            return self.rawValue
        }
    }
}
