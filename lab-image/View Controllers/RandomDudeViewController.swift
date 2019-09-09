//
//  RandomDudeViewController.swift
//  lab-image
//
//  Created by Levi Davis on 9/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class RandomDudeViewController: UIViewController {
    
    var randomDudes = [RandomDude]() {
        didSet {
            randomDudeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var randomDudeTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RandomDudeDetailViewController {
            guard let indexPath = randomDudeTableView.indexPathForSelectedRow,
                let randomDudeVC = segue.destination as? RandomDudeDetailViewController else {return}
            let oneDude = randomDudes[indexPath.row]
            randomDudeVC.oneDude = oneDude
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomDudeTableView.delegate = self
        randomDudeTableView.dataSource = self
        loadData()

        // Do any additional setup after loading the view.
    }
    

    private func loadData() {
        RandomDudeWrapper.getRandomDudeData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let randomDudes):
                    self.randomDudes = randomDudes
                }
            }
        }
    }

}

extension RandomDudeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomDudes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let oneRandomDude = randomDudes[indexPath.row]
        if let cell = randomDudeTableView.dequeueReusableCell(withIdentifier: "randomDudeCell", for: indexPath) as? RandomDudeTableViewCell {
            
            ImageHelper.shared.fetchImage(urlString: oneRandomDude.picture.thumbnail) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.randomDudeCellImage.image = image
                        
                    }
                }
            }
            
            cell.randomDudeCellNameLabel.text = oneRandomDude.fullName
            cell.randomDudeCellAgeLabel.text = "Age: \(oneRandomDude.dob.age)"
            cell.randomDudeCellMobilePhoneLabel.text = "Cell: \(oneRandomDude.cell)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

