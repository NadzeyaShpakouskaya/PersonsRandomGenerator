//
//  RandomPersonViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import UIKit

class RandomPersonViewController: UIViewController {
    
    @IBOutlet var contactImage: CachedImageView!
    @IBOutlet weak var contactInfoTableView: UITableView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    private var contacts: [Contact] = []
    private var currentContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactInfoTableView.delegate = self
        contactInfoTableView.dataSource = self
        fetchContact()
       
        setUpImage()
    }
    
    
    @IBAction func refreshButtonPressed() {
        fetchContact()
        favouriteButton.setImage(UIImage(systemName: "heart.circle"), for: .normal)
    }
    
    @IBAction func favouriteButtonPressed() {
        guard let contact = currentContact else { return }
        contacts.append(contact)
        StorageManager.shared.save(contact: contact)
        favouriteButton.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
    }
    

    
    private func fetchContact() {
        NetworkManager.shared.fetchContacts { result in
            switch result {
            case .success(let contacts):
                self.currentContact = contacts[0]
                self.contactInfoTableView.reloadData()
                self.contactImage.fetchImage(from: self.currentContact?.picture.large ?? "")

            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpImage() {
        contactImage.layer.cornerRadius = contactImage.frame.height / 2
        contactImage.layer.borderColor = UIColor.systemIndigo.cgColor
        contactImage.layer.borderWidth = 5
    }
    
    private func prepareDataForCellAt(index: Int, from contact: Contact ) -> (String, String) {
        var text = ("","")
        switch index {
        case 0: text = ("Full name: ", contact.name.fullName)
        case 1: text  = ("Age: ", String(contact.dob.age ?? 0))
        case 2: text  = ("Nationality: ", contact.nat ?? "n/a")
        case 3: text  = ("Cell: ", "\(contact.cell ?? "")")
        case 4: text  = ("Address: ", contact.location.fullAddress)
        default: break
        }
        return text
    }

}

extension RandomPersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.prefersSideBySideTextAndSecondaryText = true
        
        guard let contact = currentContact else { return cell }
        let text = prepareDataForCellAt(index: indexPath.row, from: contact)
        content.text = text.0
        content.secondaryText = text.1
        content.textProperties.font = UIFont(name: "Geeza Pro Bold", size: 14) ?? .systemFont(ofSize: 14)
        content.textProperties.color = .systemIndigo
        content.secondaryTextProperties.font = UIFont(name: "Geeza Pro Bold", size: 16) ?? .systemFont(ofSize: 16)
        content.secondaryTextProperties.color = .darkGray
        
        cell.contentConfiguration = content        
        return cell
    }
    
    
}

