//
//  PokemonViewController.swift
//  lab-image
//
//  Created by Levi Davis on 9/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemons = [Poke.Pokemon]() {
        didSet {
            pokeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var pokeTableView: UITableView!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PokeDetailViewController {
            guard let indexPath = pokeTableView.indexPathForSelectedRow,
                let pokeVC = segue.destination as? PokeDetailViewController else {return}
            let onePoke = pokemons[indexPath.row]
            pokeVC.onePoke = onePoke
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeTableView.delegate = self
        pokeTableView.dataSource = self
        pokeSearchBar.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    

    private func loadData() {
        Poke.getPokeData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let poke):
                    self.pokemons = poke
                }
            }
        }
    }
}

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let onePoke = pokemons[indexPath.row]
        let cell = pokeTableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        ImageHelper.shared.fetchImage(urlString: onePoke.imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.imageView?.image = image
                    
                }
            }
        }
        
        cell.textLabel?.text = onePoke.name
        
        
        return cell
    }
    
    
}
