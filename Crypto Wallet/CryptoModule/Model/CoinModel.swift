//
//  CoinModel.swift
//  Crypto Wallet
//
//  Created by 123 on 1.02.23.
//

import Foundation

struct Coin: Decodable {
    let data: MainData
    
    struct MainData: Decodable {
        let symbol: String
        let name: String
        var marketData: MarketData
        var marketCap: MarketCap
        
        struct MarketData: Decodable, Equatable {
            let priceUSD: Double?
            let percentChangeLast1Hour: Double?
            let percentChangeLast24Hours: Double?
        }
        
        struct MarketCap: Decodable, Equatable {
            let rank: Int?
        }
    }
}








