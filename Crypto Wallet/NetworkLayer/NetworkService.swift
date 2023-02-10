//
//  File.swift
//  Crypto Wallet
//
//  Created by 123 on 7.02.23.
//

import Foundation

final class NetworkService {
    func getCoinsAgain(urlString: String, completion: @escaping (Result<Coin?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(Coin.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
}
