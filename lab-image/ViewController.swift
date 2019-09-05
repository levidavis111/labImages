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
            loadData()
            setupDisplays()
        }
    }

    
    @IBOutlet weak var comicNumberLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var changeComicStepper: UIStepper!
    
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
    
    private func setupDisplays() {
        guard xkcd != nil else {return}
        comicNumberLabel.text = "\(xkcd?.num ?? 0)"
        
    }

}
