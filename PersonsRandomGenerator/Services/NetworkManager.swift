//
//  NetworkManager.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import Foundation
import UIKit

class NetworkManager {
    //Create Singleton
    static let shared = NetworkManager()
    private init() {}
    
    
    // Generic method to fetch Any data
    func fetchData<T:Codable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let url = URL(string: url) else {
//            print(NetworkError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "unknown data error")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                completion(.success(type))
            } catch {
                completion(.failure(error))
//                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
    case encodingError
}

