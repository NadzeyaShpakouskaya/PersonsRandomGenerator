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
    
    func fetchContacts(quantity: Int = 1, completion: @escaping (Result<[Contact], Error>) -> Void) {
        let url = Routes.urlForContacts(of: quantity)
        fetchData(dataType: ContactsInformation.self, from: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data.results))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    
    // Generic method to fetch Any data
     private func fetchData<T:Codable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let url = URL(string: url) else {
            print(NetworkError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                completion(.success(type))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
enum NetworkError: String, Error {
    case invalidUrl = "Check URL: couldn't create url"
    case noData = "No data was provided"
    case decodingError
    case encodingError = "Encoding Error: Couldn't encode model to JSON"
}

