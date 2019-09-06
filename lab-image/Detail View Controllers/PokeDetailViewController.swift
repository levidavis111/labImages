//
//  PokeDetailViewController.swift
//  lab-image
//
//  Created by Levi Davis on 9/6/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {
    
    var onePoke: Poke.Pokemon!

    @IBOutlet weak var pokeDetailImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var pokeWeaknessLabel: UILabel!
    @IBOutlet weak var pokeSetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupDetailViews() {
        getPokeImage()
        pokeNameLabel.text = onePoke.name
        pokeTypeLabel.text = "Type: \(onePoke.types?[0] ?? "No Type")"
        pokeWeaknessLabel.text = "Weakness Type: \(onePoke.weaknesses?[0].type ?? "Omnipotent"), Weakness Value: \(onePoke.weaknesses?[0].value ?? "")"
        pokeSetLabel.text = "Set: \(onePoke.set)"
    }
    
    private func getPokeImage() {
        ImageHelper.shared.fetchImage(urlString: onePoke.imageUrlHiRes) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.pokeDetailImageView.image = image
                    
                }
            }
        }
    }

}
