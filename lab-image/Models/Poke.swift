//
//  Poke.swift
//  lab-image
//
//  Created by Levi Davis on 9/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct Poke:Codable {
    let cards: [Pokemon]
    
    struct Pokemon: Codable {
        let name: String
        let imageUrlHiRes: String
        let types: [String]?
        let weaknesses: [WeaknessWrapper]?
        let set: String
        

        
        struct WeaknessWrapper: Codable {
            let type: String
            let value: String
        }
    }
    
    static func getPokeData(completionHandler: @escaping (Result<[Pokemon],AppError>) -> () ) {
        let url = "https://api.pokemontcg.io/v1/cards"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pokeResult = try JSONDecoder().decode(Poke.self, from: data)
                    
                    completionHandler(.success(pokeResult.cards))
                } catch {
                    print(error)
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
    
}
