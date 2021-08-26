//
//  Network.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 25.08.2021.
//

import Foundation

class NetworkService {
    
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}

class DataFetcher {
    
    let networkService = NetworkService()
    
    func fetchCategories(response: @escaping (Categories?) -> Void) {
        networkService.request(url: "http://62.109.7.98/api/categories") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Categories.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
    
    func fetchProducts(id: Int, response: @escaping (Products?) -> Void) {
        networkService.request(url: "http://62.109.7.98/api/product/category/\(id)") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Products.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
