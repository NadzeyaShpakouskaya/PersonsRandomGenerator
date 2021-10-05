//
//  ListViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 05/10/2021.
//

import UIKit

class ListViewController: UITableViewController {
    
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContact()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        
        let contact = contacts[indexPath.row]
        cell.setUpCellFor(contact: contact)
        return cell

    }
    
    private func fetchContact() {
        NetworkManager.shared.fetchContacts(quantity: 100) { result in
            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}
