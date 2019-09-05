//
//  XKCD.swift
//  lab-image
//
//  Created by Levi Davis on 9/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct XKCD: Codable {
    let num: Int
    let img: String
    
    static func getXKCDData(completionHandler: @escaping (Result<XKCD,AppError>) -> () ) {
       let url = "http://xkcd.com/info.0.json"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let XKCDResult = try JSONDecoder().decode(XKCD.self, from: data)
                    
                    completionHandler(.success(XKCDResult))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
}
