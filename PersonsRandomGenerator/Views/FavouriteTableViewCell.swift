//
//  FavouriteTableViewCell.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 04/10/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImage: CachedImageView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        contactImage.layer.cornerRadius = contactImage.frame.height / 2
        contactImage.layer.borderWidth = 2
        contactImage.layer.borderColor = UIColor.systemIndigo.cgColor
    }
    
    func setUpCellFor(contact: Contact) {
        contactImage.fetchImage(from: contact.picture.large ?? "")
        phoneLabel.text = contact.phone ?? "phone n/a"
        nameLabel.text = contact.name.fullName 
    }
    
    
}
