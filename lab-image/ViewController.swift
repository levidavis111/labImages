//
//  ViewController.swift
//  lab-image
//
//  Created by Levi Davis on 9/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var xkcd: XKCD? {
        didSet {
          
            setupDisplays()
        }
    }

    
    @IBOutlet weak var comicNumberLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTextFieldOutlet: UITextField!
    
    
    
    @IBAction func changeComicStepper(_ sender: UIStepper) {
//        xkcd.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicTextFieldOutlet.delegate = self
        loadData()
        setupDisplays()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        XKCD.getXKCDData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let XKCD):
                    self.xkcd = XKCD
                    
                }
            }
        }
    }
    
    private func loadImage() {
        ImageHelper.shared.fetchImage(urlString: xkcd?.img ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.comicImageView.image = image
                }
            }
        }
    }
    
    private func setupDisplays() {
        guard xkcd != nil else {return}
        comicNumberLabel.text = "XKCD# \(xkcd?.num ?? 0)"
        loadImage()
    }

}
