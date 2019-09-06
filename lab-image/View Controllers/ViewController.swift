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
    @IBOutlet weak var changeComicStepperOutlet: UIStepper!
    
    @IBAction func mostRecentComicButton(_ sender: UIButton) {
        loadData()
        
    }
    @IBAction func randomComicButton(_ sender: UIButton) {
        
        loadCustomData(sender: Int.random(in: 1...2200))
        
        
    }
    
    @IBAction func changeComicStepper(_ sender: UIStepper) {
        loadCustomData(sender: Int(sender.value))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicTextFieldOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        XKCD.getXKCDData(comicNum: nil) { (result) in
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
        comicNumberLabel.text = "XKCD# \(xkcd?.num ?? 0)"
        loadImage()
    }
    
    private func loadCustomData(sender: Int) {
        changeComicStepperOutlet.value = Double(sender)
        XKCD.getXKCDData(comicNum: sender) { (result) in
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
    
    private func setStepperValue(int: Int) {
        changeComicStepperOutlet.value = Double(int)
    }

}
