//
//  RandomDude.swift
//  lab-image
//
//  Created by Levi Davis on 9/6/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct RandomDudeWrapper: Codable {
    let results: [RandomDude]
    
    static func getRandomDudeData(completionHandler: @escaping (Result<[RandomDude],AppError>) -> () ) {
        let url = "https://randomuser.me/api/?results=50"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let randomDudeResult = try JSONDecoder().decode(RandomDudeWrapper.self, from: data)
                    completionHandler(.success(randomDudeResult.results))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }

}

struct RandomDude: Codable {
//    let results: [RandomDude]
    
   
        let name: NameWrapper
        let dob: AgeWrapper
        let phone: String
        let location: LocationWrapper
        let cell: String
        let picture: PictureWrapper
        var fullName: String {get {
            return "\(String(describing: name.first)) \(String(describing: name.last))"
            }
        }
        
    
    
    struct NameWrapper: Codable {
        let first: String
        let last: String
    }
    
    struct AgeWrapper: Codable {
        let age: Int
    }
    
    struct PictureWrapper: Codable {
        let thumbnail: String
        let large: String
    }
    struct LocationWrapper: Codable {
        let street: String
        let city: String
        let state: String
    }
    
}
