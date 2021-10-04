//
//  FavouritesListViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 04/10/2021.
//

import UIKit

class FavouritesListViewController: UITableViewController {
    
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = StorageManager.shared.fetchContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contacts = StorageManager.shared.fetchContacts()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavouriteTableViewCell

        let contact = contacts[indexPath.row]
        cell.setUpCellFor(contact: contact)

        return cell
    }



    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deleteContact(at: indexPath.row)
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)


        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        guard let vc = segue.destination as? DetailedViewController else { return }
        let contact = contacts[index]
        vc.contact = contact
        vc.indexOfContact = index
    }

}
