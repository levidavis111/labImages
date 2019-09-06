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
    
    struct RandomDude: Codable {
        let name: [NameWrapper]
        let dob: [AgeWrapper]
        let cell: String
        var fullName: String {get {
            return "\(String(describing: name.first)) \(String(describing: name.last))"
            }
        }
        
    }
    
    struct NameWrapper: Codable {
        let first: String
        let last: String
    }
    
    struct AgeWrapper: Codable {
        let age: Int
    }
}
