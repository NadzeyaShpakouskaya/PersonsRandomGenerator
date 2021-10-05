//
//  Routes.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import Foundation


struct Routes {
    static let basicURL = "https://randomuser.me/api/"
    
    static func urlForContacts(of number: Int) -> String {
        "\(basicURL)?results=\(number)"
    }
    
    static func urlForContacts(of number: Int, page: Int) -> String {
        "\(basicURL)?page=\(page)&results=\(number)"
    }
    
}
