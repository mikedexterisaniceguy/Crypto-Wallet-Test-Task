//
//  Cell + func.swift
//  Crypto Wallet
//
//  Created by 123 on 10.02.23.
//

import Foundation
import UIKit

extension UITableViewCell {
    func setCoinView(coinNameLabel: UILabel, coinImage: UIImageView) {
        let coinName = coinNameLabel.text
        switch coinName {
        case "Terra": coinImage.image = UIImage(named: "terra")
        case "Polkadot": coinImage.image = UIImage(named: "polkadot")
        case "Cardano": coinImage.image = UIImage(named: "cardano")
        case "Dogecoin": coinImage.image = UIImage(named: "dogecoin")
        case "Bitcoin": coinImage.image = UIImage(named: "bitcoin")
        case "Ethereum": coinImage.image = UIImage(named: "ethereum")
        case "XRP": coinImage.image = UIImage(named: "xrp")
        case "Stellar": coinImage.image = UIImage(named: "stellar")
        case "Tether": coinImage.image = UIImage(named: "tether")
        case "TRON": coinImage.image = UIImage(named: "tron")
        default: break
        }
    }
}
