//
//  NetworkService.swift
//  MyTravelHelper
//
//  Created by Rahul Gera on 24/05/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
enum NetworkError: Error {
    case badURL
    case noData
}

class BaseDataServiceProvider {
    
    func fetch(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void)  {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            completionHandler(.success(data))
        }
        task.resume()
    }
}

