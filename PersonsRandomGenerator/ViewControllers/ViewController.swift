//
//  ViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContactList()
    }
    
    private func fetchContactList() {
        // Do any additional setup after loading the view.
        NetworkManager.shared.fetchData(dataType: ContactsInformation.self, from: "https://randomuser.me/api/") { results in
            switch results {
            case .success(let data):
                let contacts = data.results
                print(contacts)
            case .failure(let error):
                print(error)
            }
        }
    }
    



}

