//
//  ListTableViewCell.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 05/10/2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: CachedImageView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    private var currentContact: Contact?
    
    override func awakeFromNib() {
        contactImage.layer.cornerRadius = contactImage.frame.height / 2
        contactImage.layer.borderWidth = 2
        contactImage.layer.borderColor = UIColor.systemIndigo.cgColor
    }
    
    func setUpCellFor(contact: Contact) {
        currentContact = contact
        contactImage.fetchImage(from: contact.picture.large ?? "")
        phoneLabel.text = contact.phone ?? "phone n/a"
        nameLabel.text = contact.name.fullName
    }
    
    override func prepareForReuse() {
        favouriteButton.setImage(UIImage(systemName: "heart.circle"), for: .normal)
    }
    
    @IBAction func favouriteButtonPressed() {
        guard let contact = currentContact else { return }
        StorageManager.shared.save(contact: contact)
        favouriteButton.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
    }
    
    
}
