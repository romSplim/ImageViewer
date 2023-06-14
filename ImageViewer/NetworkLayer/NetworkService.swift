//
//  NetworkService.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import Foundation

final class NetworkService {
    
    //MARK: - Properties
    private var session: URLSession
    private var decoder: JSONDecoder
    
    //MARK: - Init
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.session = session
        self.decoder = decoder
    }
    
    //MARK: - Methods
    
    func getRandomListPhotos(completion: @escaping (Result<[PhotoItem], NetworkError>) -> Void) {
        guard let request = APIManager.getRandomListImages.request() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode([PhotoItem].self,
                                                         from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
    
    func searchPhoto(with name: String, completion: @escaping (Result<[PhotoItem], NetworkError>) -> Void) {
        guard let request = APIManager.searchPhoto(name: name).request() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode(SearchResponse.self,
                                                         from: data)
                    let photos = result.results
                    completion(.success(photos))
                } catch let error {
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
}
