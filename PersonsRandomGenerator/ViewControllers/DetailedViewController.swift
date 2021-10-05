//
//  DetailedViewController.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 04/10/2021.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var contactImage: CachedImageView!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var contact: Contact!
    var indexOfContact: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        setUpImages()
        
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        StorageManager.shared.deleteContact(at: indexOfContact)
        sender.alpha = 0
        sender.isEnabled = false
  
    }
    
    
    private func setUpLabels() {
        nameLabel.text = contact.name.fullName
        genderLabel.text = contact.gender
        addressLabel.text = contact.location.fullAddress
        ageLabel.text = "\(contact.dob.age ?? 18)"
        phoneLabel.text = "\(contact.cell ?? "n/a"),\n\(contact.phone ?? "n/a")"
        emailLabel.text = contact.email
    }
    
    private func setUpImages() {
        contactImage.fetchImage(from: contact.picture.large ?? "")
        contactImage.layer.cornerRadius = contactImage.frame.height / 2
        contactImage.layer.borderColor = UIColor.systemIndigo.cgColor
        contactImage.layer.borderWidth = 5
    }
    
    
}
