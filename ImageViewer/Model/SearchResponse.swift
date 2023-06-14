//
//  SearchResponse.swift
//  ImageViewer
//
//  Created by ramil on 12.06.2023.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [PhotoItem]
}
