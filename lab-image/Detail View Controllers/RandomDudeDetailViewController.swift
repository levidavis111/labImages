//
//  RandomDudeDetailViewController.swift
//  lab-image
//
//  Created by Levi Davis on 9/6/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit



class RandomDudeDetailViewController: UIViewController {
    
    var oneDude: RandomDude!
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var ageDetailLabel: UILabel!
    @IBOutlet weak var homePhoneDetailLabel: UILabel!
    @IBOutlet weak var cellPhoneDetailLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var miscDetailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    private func setupViews() {
        getDudeImage()
        nameDetailLabel.text = oneDude.fullName
        ageDetailLabel.text = "Age: \(oneDude.dob.age)"
        homePhoneDetailLabel.text = "Home Phone: \(oneDude.phone)"
        cellPhoneDetailLabel.text = "Cell: \(oneDude.cell)"
        locationDetailLabel.text = "\(oneDude.location.street), \(oneDude.location.city)"
        miscDetailLabel.text = "Hi mom!"
    }
    
    private func getDudeImage() {
        ImageHelper.shared.fetchImage(urlString: oneDude.picture.large) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.detailImageView.image = image
                    
                }
            }
        }
    }
}


