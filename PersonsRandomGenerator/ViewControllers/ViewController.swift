//
//  ViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import UIKit

class ViewController: UIViewController {
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContactList()
    }
    
    private func fetchContactList() {
        NetworkManager.shared.fetchContacts { result in
            switch result {
            case .success(let contact):
                self.contacts = contact
                print(self.contacts)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    



}

