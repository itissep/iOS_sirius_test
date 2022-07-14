//
//  NetworkingManager.swift
//  iOS_sirius_test
//
//  Created by The GORDEEVS on 12.07.2022.
//

import Foundation

struct NetworkingManager {
    static let shared = NetworkingManager()
    let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    private init() {}
    
    func fetchServices(_ complition: @escaping ([Service]?) -> Void ){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decodedData = try? JSONDecoder().decode(Response.self, from: safeData)
                    complition(decodedData?.body.services)
                }
            }
            task.resume()
        }
    }
}
