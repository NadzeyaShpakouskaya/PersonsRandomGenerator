//
//  Contact.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import Foundation
import Metal

struct ContactsInformation: Codable {
    let results: [Contact]
    let info: Info
}

struct Contact: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: LoginInfo
    let dob: DateBirthInfo
    let registered: RegistrationInfo
    let phone: String
    let cell: String
    let id: IdInfo
    let picture: PicturesInfo
    let nat: String
}

struct Info: Codable {
    let results: Int
    let page: Int
}


struct Name: Codable {
    let title: String
    let first: String
    let last: String
    
    var fullName: String {
        "\(title). \(first) \(last)"
    }
}

struct Location: Codable {
    let street: Street
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    
    var fullAddress: String {
        "\(street.lineAddress), \(city ?? ""), \(state ?? ""), \(country ?? "")"
    }
}

struct Street: Codable {
    let number: Int?
    let name: String?
   
    var lineAddress: String {
        "\(name ?? ""). \(number ?? 0)"
    }
}

struct LoginInfo: Codable {
    let uuid: String?
    let username: String?
    let password: String?
}

struct DateBirthInfo: Codable {
    let date: String?
    let age: Int?
}

struct RegistrationInfo: Codable {
    let date: String?
    let age: Int?
}

struct IdInfo: Codable {
    let name: String?
    let value: String?
}

struct PicturesInfo: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
