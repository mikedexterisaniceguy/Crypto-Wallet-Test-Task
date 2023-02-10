//
//  CoinModel + enums.swift
//  Crypto Wallet
//
//  Created by 123 on 10.02.23.
//

import Foundation

extension Coin.MainData {
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case marketData = "market_data"
        case marketCap = "marketcap"
    }
}

extension Coin.MainData.MarketData {
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case percentChangeLast1Hour = "percent_change_usd_last_1_hour"
        case percentChangeLast24Hours = "percent_change_usd_last_24_hours"
    }
}
